{ config, ... }:

{
  # Certificate files - use build-time resolved path to avoid pure evaluation issues
  security.pki.certificateFiles = [
    "${config.system.build.toplevel}/certs/caddy-local-root.crt"
  ];
}
