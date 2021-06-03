import Config

config :whether,
  http_request: &Whether.Test.FakePoison.get/1,
  reccomendations_data: "config/testData.json",
  api_key: ""
