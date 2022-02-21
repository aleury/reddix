defmodule Reddix.ThreadsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Reddix.Threads` context.
  """

  @doc """
  Generate a thread.
  """
  def thread_fixture(attrs \\ %{}) do
    {:ok, thread} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> Reddix.Threads.create_thread()

    thread
  end
end
