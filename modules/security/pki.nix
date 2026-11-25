{ config, ... }:

{
  # Certificate files - use build-time resolved path to avoid pure evaluation issues
  security.pki.certificateFiles = [
    ../../certs/caddy-local-root.crt
  ];
}
