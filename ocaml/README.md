# Antybrowser OCaml SDK

OCaml client library for the [Antybrowser](https://antybrowser.com) Local API.

## Requirements

- OCaml >= 4.12
- Dune >= 3.0
- Antybrowser running locally (default port 5173)

## Dependencies

- `cohttp-lwt-unix` — HTTP client
- `yojson` — JSON serialization
- `uri` — URI construction
- `lwt` — async concurrency

## Install

### Via opam

```bash
opam install antybrowser
```

### From source

```bash
cd ocaml
dune build
dune install
```

## Usage

```ocaml
open Antybrowser

let () =
  let client = Client.create ~api_key:"your-api-key" () in

  (* Check API status *)
  let status = Lwt_main.run (Client.get_status client) in
  Printf.printf "API status: %s (v%s)\n" status.Antybrowser_types.status status.Antybrowser_types.version;

  (* List profiles *)
  let profiles = Lwt_main.run (Client.get_profiles client) in
  List.iter (fun p ->
    Printf.printf "Profile %d: %s\n" p.Antybrowser_types.id p.Antybrowser_types.name
  ) profiles;

  (* Create a profile *)
  let new_profile = Lwt_main.run (Client.create_profile client
    { Antybrowser_types.name = "My Profile"
    ; directory_name = None
    ; group_id = None
    ; proxy_id = None
    ; browser_type = Some "chromium"
    ; os_fingerprint = None
    ; screen_resolution = None
    ; language = None
    ; accept_language = None
    ; timezone = None
    ; use_fingerprint = None
    ; fingerprint_id = None
    ; restore_session = None
    ; low_bandwidth = None
    ; notes = None
    ; start_url = None
    ; custom_flags = None
    }) in
  Printf.printf "Created profile: %d\n" new_profile.Antybrowser_types.id
```

## Custom Configuration

```ocaml
(* Custom port *)
let client = Client.create ~api_key:"key" ~port:8080 () in

(* Full base URL override *)
let client = Client.create ~api_key:"key" ~base_url:"http://192.168.1.100:5173" () in

(* Custom timeout (seconds) *)
let client = Client.create ~api_key:"key" ~timeout:60.0 () in
```

## Error Handling

All client functions raise `Antybrowser_error` on failure:

```ocaml
try
  let status = Lwt_main.run (Client.get_status client) in
  ...
with Antybrowser_error (msg, status_code, response_body) ->
  Printf.eprintf "Error %s (HTTP %d)\n" msg (Option.value ~default:0 status_code)
```

## License

MIT — see [LICENSE](LICENSE).
