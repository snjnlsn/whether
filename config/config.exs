import Config

config :whether,
  reccomendations: [:min_temp, :max_temp, :waterproof, :terrain]

import_config("./secret.exs")
import_config("#{config_env()}.exs")
