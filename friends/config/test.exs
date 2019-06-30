use Mix.Config

config :friends, Friends.Repo,
  database: "friends_repo",
  username: "user",
  password: "pass",
  hostname: "localhost",
  port: 15432,
  pool: Ecto.Adapters.SQL.Sandbox

config :friends, ecto_repos: [Friends.Repo]
