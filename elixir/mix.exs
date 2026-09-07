defmodule Antybrowser.MixProject do
  use Mix.Project

  def project do
    [
      app: :antybrowser,
      version: "1.0.2",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: [
        {:httpoison, "~> 2.0"},
        {:jason, "~> 1.4"}
      ],
      description: "Official Antybrowser SDK — Elixir client for the Antybrowser Local API",
      package: [
        name: "antybrowser",
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/antybrowser/SDK", "Website" => "https://antybrowser.com"},
        files: ~w(lib mix.exs README.md LICENSE)
      ]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:jason, "~> 1.4"}
    ]
  end
end
