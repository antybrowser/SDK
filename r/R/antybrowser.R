#' Antybrowser R Client
#'
#' Official R client for the Antybrowser Local API.
#'
#' @docType package
#' @name antybrowser-package
NULL

#' Create an Antybrowser client
#'
#' @param api_key Your API key from Antybrowser settings
#' @param port API port (default 5173)
#' @return An AntybrowserClient object
#' @export
AntybrowserClient <- function(api_key, port = 5173) {
  structure(
    list(
      api_key = api_key,
      base_url = paste0("http://127.0.0.1:", port)
    ),
    class = "AntybrowserClient"
  )
}

.do_request <- function(client, method, path, body = NULL) {
  url <- paste0(client$base_url, path)
  headers <- c("x-api-key" = client$api_key, "Content-Type" = "application/json")

  response <- switch(method,
    GET = httr::GET(url, httr::add_headers(.headers = headers)),
    POST = httr::POST(url, httr::add_headers(.headers = headers), body = if (!is.null(body)) jsonlite::toJSON(body, auto_unbox = TRUE) else "{}", encode = "raw"),
    PUT = httr::PUT(url, httr::add_headers(.headers = headers), body = if (!is.null(body)) jsonlite::toJSON(body, auto_unbox = TRUE) else "{}", encode = "raw"),
    DELETE = httr::DELETE(url, httr::add_headers(.headers = headers))
  )

  if (httr::status_code(response) >= 400) {
    stop(paste("API error", httr::status_code(response), ":", httr::content(response, "text")))
  }
  jsonlite::fromJSON(httr::content(response, "text"), simplifyVector = FALSE)
}

#' @rdname AntybrowserClient
#' @export
get_status <- function(client) .do_request(client, "GET", "/api/status")
#' @export
get_settings <- function(client) .do_request(client, "GET", "/api/settings")
#' @export
get_sync_status <- function(client) .do_request(client, "GET", "/api/sync/status")
#' @export
refresh_sync <- function(client, profile_id = NULL) {
  body <- if (!is.null(profile_id)) list(profileId = profile_id) else list()
  .do_request(client, "POST", "/api/sync/refresh", body)
}

#' @rdname AntybrowserClient
#' @export
get_profiles <- function(client) .do_request(client, "GET", "/api/profiles")
#' @export
create_profile <- function(client, data) .do_request(client, "POST", "/api/profiles", data)
#' @export
update_profile <- function(client, id, data) .do_request(client, "PUT", paste0("/api/profiles/", id), data)
#' @export
delete_profile <- function(client, id) .do_request(client, "DELETE", paste0("/api/profiles/", id))
#' @export
start_profile <- function(client, id) .do_request(client, "POST", paste0("/api/profiles/", id, "/start"))
#' @export
stop_profile <- function(client, id) .do_request(client, "POST", paste0("/api/profiles/", id, "/stop"))
#' @export
duplicate_profile <- function(client, id, name = NULL) {
  body <- if (!is.null(name)) list(name = name) else list()
  .do_request(client, "POST", paste0("/api/profiles/", id, "/duplicate"), body)
}

#' @rdname AntybrowserClient
#' @export
get_automations <- function(client) .do_request(client, "GET", "/api/automations")
#' @export
run_automation <- function(client, id, profile_id) .do_request(client, "POST", paste0("/api/automations/", id, "/run"), list(profileId = profile_id))

#' @rdname AntybrowserClient
#' @export
get_groups <- function(client) .do_request(client, "GET", "/api/groups")
#' @export
create_group <- function(client, data) .do_request(client, "POST", "/api/groups", data)
#' @export
update_group <- function(client, id, data) .do_request(client, "PUT", paste0("/api/groups/", id), data)
#' @export
delete_group <- function(client, id) .do_request(client, "DELETE", paste0("/api/groups/", id))

#' @rdname AntybrowserClient
#' @export
get_proxies <- function(client) .do_request(client, "GET", "/api/proxies")
#' @export
create_proxy <- function(client, data) .do_request(client, "POST", "/api/proxies", data)
#' @export
check_proxy <- function(client, data) .do_request(client, "POST", "/api/proxies/check", data)
#' @export
delete_proxy <- function(client, id) .do_request(client, "DELETE", paste0("/api/proxies/", id))

#' @rdname AntybrowserClient
#' @export
get_extensions <- function(client) .do_request(client, "GET", "/api/extensions")
#' @export
delete_extension <- function(client, id) .do_request(client, "DELETE", paste0("/api/extensions/", id))
#' @export
get_profile_extensions <- function(client, profile_id) .do_request(client, "GET", paste0("/api/profiles/", profile_id, "/extensions"))
#' @export
set_profile_extensions <- function(client, profile_id, extension_ids) {
  .do_request(client, "POST", paste0("/api/profiles/", profile_id, "/extensions"), list(extensionIds = extension_ids))
}
