defmodule Antybrowser do
  @moduledoc "Official Antybrowser SDK — Elixir client for the Antybrowser Local API"

  defstruct [:api_key, :base_url]

  def new(api_key, opts \\ []) do
    port = Keyword.get(opts, :port, 5173)
    %__MODULE__{
      api_key: api_key,
      base_url: "http://127.0.0.1:#{port}"
    }
  end

  # System
  def get_status(client), do: get(client, "/api/status")
  def get_settings(client), do: get(client, "/api/settings")
  def get_sync_status(client), do: get(client, "/api/sync/status")

  def refresh_sync(client, profile_id \\ nil) do
    body = if profile_id, do: %{profileId: profile_id}, else: %{}
    post(client, "/api/sync/refresh", body)
  end

  # Profiles
  def get_profiles(client), do: get(client, "/api/profiles")
  def create_profile(client, data), do: post(client, "/api/profiles", data)
  def update_profile(client, id, data), do: put(client, "/api/profiles/#{id}", data)
  def delete_profile(client, id), do: delete(client, "/api/profiles/#{id}")
  def start_profile(client, id), do: post(client, "/api/profiles/#{id}/start", %{})
  def stop_profile(client, id), do: post(client, "/api/profiles/#{id}/stop", %{})

  def duplicate_profile(client, id, name \\ nil) do
    body = if name, do: %{name: name}, else: %{}
    post(client, "/api/profiles/#{id}/duplicate", body)
  end

  # Automations
  def get_automations(client), do: get(client, "/api/automations")
  def run_automation(client, id, profile_id), do: post(client, "/api/automations/#{id}/run", %{profileId: profile_id})

  # Groups
  def get_groups(client), do: get(client, "/api/groups")
  def create_group(client, data), do: post(client, "/api/groups", data)
  def update_group(client, id, data), do: put(client, "/api/groups/#{id}", data)
  def delete_group(client, id), do: delete(client, "/api/groups/#{id}")

  # Proxies
  def get_proxies(client), do: get(client, "/api/proxies")
  def create_proxy(client, data), do: post(client, "/api/proxies", data)
  def check_proxy(client, data), do: post(client, "/api/proxies/check", data)
  def delete_proxy(client, id), do: delete(client, "/api/proxies/#{id}")

  # Extensions
  def get_extensions(client), do: get(client, "/api/extensions")
  def delete_extension(client, id), do: delete(client, "/api/extensions/#{id}")
  def get_profile_extensions(client, profile_id), do: get(client, "/api/profiles/#{profile_id}/extensions")

  def set_profile_extensions(client, profile_id, extension_ids) do
    post(client, "/api/profiles/#{profile_id}/extensions", %{extensionIds: extension_ids})
  end

  # HTTP
  defp get(client, path), do: request(client, :get, path, nil)
  defp post(client, path, body), do: request(client, :post, path, body)
  defp put(client, path, body), do: request(client, :put, path, body)
  defp delete(client, path), do: request(client, :delete, path, nil)

  defp request(client, method, path, body) do
    url = client.base_url <> path
    headers = [{"x-api-key", client.api_key}, {"Content-Type", "application/json"}]

    result = case method do
      :get -> HTTPoison.get(url, headers)
      :post -> HTTPoison.post(url, Jason.encode!(body), headers)
      :put -> HTTPoison.put(url, Jason.encode!(body), headers)
      :delete -> HTTPoison.delete(url, headers)
    end

    case result do
      {:ok, %HTTPoison.Response{status_code: code, body: resp_body}} when code in 200..299 ->
        {:ok, Jason.decode!(resp_body)}
      {:ok, %HTTPoison.Response{status_code: code, body: resp_body}} ->
        {:error, %{status_code: code, body: resp_body}}
      {:error, reason} ->
        {:error, reason}
    end
  end
end
