defmodule CogWeb.Router do
  use CogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CogWeb do
    pipe_through :api
  end
end
