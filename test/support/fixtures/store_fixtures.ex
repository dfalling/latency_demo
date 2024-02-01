defmodule Latency.StoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Latency.Store` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Latency.Store.create_item()

    item
  end
end
