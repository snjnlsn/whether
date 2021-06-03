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

## Development Thoughts:

#### Proud of:
- Use of TDD, especially practicing configuration/mocking the OpenWeather API
- Implementation design, especially use of Ecto changesets to import and filter items based off current weather.

#### Stumbling Blocks:
- Implmenting the new Config module, and environment-specific configuration. This has previously come for free in older Mix projects/Phoenix projects, so I had to learn how to add it as this was built in Elixir 1.12 / OTP 24.
- Finding a way to build the app – I stumbled around some confusion with compilation and module importing in .exs files before landing on an EScript implementation that I'm happy with.

#### Future Enhancements
- Handling edge cases:
  - Unknown cities are weakly guarded only by asking if the user typo'd
  - 0 items returning given the current weather should emit a special message
  - I don't handle the user passing args incorrectly into the CLI
- More tests would be cool
