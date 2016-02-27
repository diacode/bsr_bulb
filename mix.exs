defmodule BSRBulb.Mixfile do
  use Mix.Project

  def project do
    [ app: :bsr_bulb,
      version: "0.0.1",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { BSRBulb, [] }]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:exactor, github: "sasa1977/exactor"},
      {:"erlang-serial", github: "knewter/erlang-serial", app: false}
    ]
  end
end
