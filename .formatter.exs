[
  import_deps: [:ecto, :phoenix],
  inputs: ["*.{ex,exs}", "priv/repo/*.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"]
]
