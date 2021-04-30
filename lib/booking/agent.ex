defmodule Exflight.Bookings.Agent do
  alias Exflight.Bookings.Booking
  use Agent

  def start_link(_init_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{id: id} = booking) do
    Agent.update(__MODULE__, fn state -> update_state(state, booking, id) end)

    {:ok, id}
  end

  defp update_state(state, %Booking{} = booking, uuid) do
    Map.put(state, uuid, booking)
  end

  def get(booking_id) do
    Agent.get(__MODULE__, fn state -> get_booking(state, booking_id) end)
  end

  def list_all, do: Agent.get(__MODULE__, fn state -> state end)

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Flight Booking not found"}
      booking -> {:ok, booking}
    end
  end
end
