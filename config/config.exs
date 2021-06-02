import Config

config :whether,
  reccomendations: [:min_temp, :max_temp, :waterproof, :terrain]

import_config("./secret.exs")
