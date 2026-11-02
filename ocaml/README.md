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
    ; browser_type = Some "Chrome"
    ; browser_version = None
    ; os_fingerprint = None
    ; screen_resolution = None
    ; screen_maximizable = None
    ; language = None
    ; accept_language = None
    ; timezone = None
    ; use_fingerprint = None
    ; platform_version = None
    ; brand_version = None
    ; engine_version = None
    ; gpu_vendor = None
    ; gpu_model = None
    ; hardware_concurrency = None
    ; device_memory = None
    ; device_scale_factor = None
    ; mobile_model = None
    ; mobile_version = None
    ; ch_platform = None
    ; ch_platform_version = None
    ; ch_arch = None
    ; ch_bitness = None
    ; ch_model = None
    ; ch_mobile = None
    ; disable_spoofing = None
    ; location_mode = None
    ; location_latitude = None
    ; location_longitude = None
    ; location_accuracy = None
    ; restore_session = None
    ; low_bandwidth = None
    ; notes = None
    ; start_url = None
    ; custom_flags = None
    ; status = None
    ; hidden = None
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
  let profiles = Lwt_main.run (Client.get_profiles client) in
  ...
with Antybrowser_error (msg, status_code, response_body) ->
  Printf.eprintf "Error %s (HTTP %d)\n" msg (Option.value ~default:0 status_code)
```

## License

MIT — see [LICENSE](LICENSE).
