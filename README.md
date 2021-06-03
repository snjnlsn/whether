# Whether

CLI Escript app that returns a list of reccomended items to bring given the current weather.

## Setup

- Create a config/secret.exs and add your OpenWeather API token like so:

```
import Config

config :whether,
  api_key: YOUR_KEY_HERE

```

- If desired, add/edit list items in `config/items.json`.
- If source code is edited, app can be recompiled by running `mix escript.build`
- To get reccomendations, run `./whether --state=YOUR_STATE --city=YOUR_CITY` from root directory of repo
