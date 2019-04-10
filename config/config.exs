use Mix.Config

# Don't import the secrets.exs file in travis CI because its not avialable there.
# It is needed in all other enviorments.
# Travis then requires that the VCR files (in /fxture) are created and commited.

if !System.get_env("TRAVIS") do
  import_config "secrets.exs"
end

config :exvcr,
  filter_request_headers: ["Authorization"]
