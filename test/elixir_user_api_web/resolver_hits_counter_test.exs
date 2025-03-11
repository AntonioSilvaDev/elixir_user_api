defmodule ElixirUserApiWeb.ResolverHitsCounterTest do
  use ExUnit.Case, async: true

  alias ElixirUserApiWeb.ResolverHitsCounter

  setup do
    {:ok, hits_counter} = ResolverHitsCounter.start_link(name: :foo)
    %{hits_counter: hits_counter}
  end

  test "stores and gets hit by key", context do
    assert ResolverHitsCounter.get_hits(context.hits_counter, "create_user") === 0

    ResolverHitsCounter.add_hit(context.hits_counter, "create_user")

    assert ResolverHitsCounter.get_hits(context.hits_counter, "create_user") === 1
  end

  test "can get all hits", context do
    assert ResolverHitsCounter.get_all_hits(context.hits_counter) === %{}

    ResolverHitsCounter.add_hit(context.hits_counter, "create_user")
    ResolverHitsCounter.add_hit(context.hits_counter, "update_user")

    assert ResolverHitsCounter.get_all_hits(context.hits_counter) === %{
             "create_user" => 1,
             "update_user" => 1
           }
  end
end
