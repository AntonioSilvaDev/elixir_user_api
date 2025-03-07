defmodule ElixirUserApiWeb.ResolverHitsCounter do
  @moduledoc false

  use Agent

  @default_name __MODULE__

  def start_link(opts \\ []) do
    initial_state = %{}
    opts = Keyword.put_new(opts, :name, @default_name)

    Agent.start_link(fn -> initial_state end, opts)
  end

  def add_hit(name \\ @default_name, mutation_name_key) do
    Agent.update(name, fn state ->
      Map.update(state, mutation_name_key, 1, &(&1 + 1))
    end)
  end

  def get_hits(name \\ @default_name, mutation_name) do
    Agent.get(name, &Map.get(&1, mutation_name, 0))
  end

  def get_all_hits(name \\ @default_name) do
    Agent.get(name, & &1)
  end
end
