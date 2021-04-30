defmodule Exflight.Users.Agent do
  alias Exflight.Users.User

  use Agent

  def start_link(_init_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{id: id} = user) do
    Agent.update(__MODULE__, fn state -> update_state(state, user, id) end)

    {:ok, id}
  end

  defp update_state(state, %User{} = user, uuid) do
    Map.put(state, uuid, user)
  end

  def get(user_id) do
    Agent.get(__MODULE__, fn state -> get_user(state, user_id) end)
  end

  def list_all, do: Agent.get(__MODULE__, fn state -> state end)

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
