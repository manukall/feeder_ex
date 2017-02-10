defmodule FeederEx.Mixfile do
  use Mix.Project

  def project do
    [app: :feeder_ex,
     version: "1.0.1",
     elixir: "~> 1.0",
     deps: deps(),
     package: package()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :feeder]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:feeder, git: "git@github.com:mojotech/feeder.git", sha: "db4e3e172fa7e2ee4e1f84ca2d30cafef5e34c56"},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package do
    [maintainers: ["Manuel Kallenbach"],
     licenses: ["MIT"],
     description: "RSS feed parser. Simple wrapper for feeder.",
     links: %{"GitHub" => "https://github.com/manukall/feeder_ex",
              "Feeder" => "https://github.com/michaelnisi/feeder"}]
  end
end
