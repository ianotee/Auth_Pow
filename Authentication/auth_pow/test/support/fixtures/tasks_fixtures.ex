defmodule AuthPow.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AuthPow.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        complete: true,
        description: "some description"
      })
      |> AuthPow.Tasks.create_task()

    task
  end
end
