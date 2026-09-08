exception Antybrowser_error of string * int option * string option

let to_string (msg, status_code, response_body) =
  let base = msg in
  match status_code, response_body with
  | Some code, Some body ->
    Printf.sprintf "%s (status %d): %s" base code body
  | Some code, None ->
    Printf.sprintf "%s (status %d)" base code
  | None, Some body ->
    Printf.sprintf "%s: %s" base body
  | None, None -> base
