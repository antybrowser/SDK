module Antybrowser

using HTTP
using JSON3

export AntybrowserClient
export get_profiles, create_profile, update_profile, delete_profile, start_profile, stop_profile, duplicate_profile
export get_automations, run_automation
export get_groups, create_group, update_group, delete_group
export get_proxies, create_proxy, delete_proxy
export get_extensions, delete_extension

struct AntybrowserError <: Exception
    message::String
    status_code::Union{Int,Nothing}
    body::Union{String,Nothing}
end

AntybrowserError(msg::String) = AntybrowserError(msg, nothing, nothing)

Base.showerror(io::IO, e::AntybrowserError) = print(io, "AntybrowserError: ", e.message)

struct AntybrowserClient
    api_key::String
    base_url::String
end

function AntybrowserClient(api_key::String; port::Int=5173)
    AntybrowserClient(api_key, "http://127.0.0.1:$port")
end

function _request(c::AntybrowserClient, method::Symbol, path::String, body=nothing)
    url = c.base_url * path
    headers = Dict("x-api-key" => c.api_key, "Content-Type" => "application/json")

    resp = if method == :GET
        HTTP.get(url; headers=headers)
    elseif method == :POST
        HTTP.post(url; headers=headers, body=body !== nothing ? JSON3.write(body) : "{}")
    elseif method == :PUT
        HTTP.put(url; headers=headers, body=body !== nothing ? JSON3.write(body) : "{}")
    elseif method == :DELETE
        HTTP.delete(url; headers=headers)
    end

    if resp.status >= 400
        throw(AntybrowserError("HTTP $(resp.status): $(String(resp.body))", resp.status, String(resp.body)))
    end
    JSON3.read(String(resp.body))
end

# Profiles
get_profiles(c::AntybrowserClient) = _request(c, :GET, "/api/profiles")
create_profile(c::AntybrowserClient, data) = _request(c, :POST, "/api/profiles", data)
update_profile(c::AntybrowserClient, id, data) = _request(c, :PUT, "/api/profiles/$id", data)
delete_profile(c::AntybrowserClient, id) = _request(c, :DELETE, "/api/profiles/$id")
start_profile(c::AntybrowserClient, id; headless::Bool=false) =
    _request(c, :POST, "/api/profiles/$id/start", headless ? Dict("headless" => true) : nothing)
stop_profile(c::AntybrowserClient, id) = _request(c, :POST, "/api/profiles/$id/stop")
duplicate_profile(c::AntybrowserClient, id, name=nothing) = _request(c, :POST, "/api/profiles/$id/duplicate", name !== nothing ? Dict("name" => name) : Dict())

# Automations
get_automations(c::AntybrowserClient) = _request(c, :GET, "/api/automations")
run_automation(c::AntybrowserClient, id, profile_id) = _request(c, :POST, "/api/automations/$id/run", Dict("profileId" => profile_id))

# Groups
get_groups(c::AntybrowserClient) = _request(c, :GET, "/api/groups")
create_group(c::AntybrowserClient, data) = _request(c, :POST, "/api/groups", data)
update_group(c::AntybrowserClient, id, data) = _request(c, :PUT, "/api/groups/$id", data)
delete_group(c::AntybrowserClient, id) = _request(c, :DELETE, "/api/groups/$id")

# Proxies
get_proxies(c::AntybrowserClient) = _request(c, :GET, "/api/proxies")
create_proxy(c::AntybrowserClient, data) = _request(c, :POST, "/api/proxies", data)
delete_proxy(c::AntybrowserClient, id) = _request(c, :DELETE, "/api/proxies/$id")

# Extensions
get_extensions(c::AntybrowserClient) = _request(c, :GET, "/api/extensions")
delete_extension(c::AntybrowserClient, id) = _request(c, :DELETE, "/api/extensions/$id")

end
