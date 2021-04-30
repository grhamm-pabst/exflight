defmodule Exflight.Bookings.Facade do
  alias Exflight.Bookings.Agent, as: BookingAgent
  alias Exflight.Bookings.Booking
  alias Exflight.Users.Agent, as: UserAgent

  def create(%{
        origin_city: origin_city,
        destination_city: destination_city,
        user_id: user_id
      }) do
    booking = Booking.build(origin_city, destination_city, user_id)

    with {:ok, _user} <- UserAgent.get(user_id) do
      save_booking(booking)
    else
      error -> error
    end
  end

  def save_booking({:ok, %Booking{} = booking}) do
    BookingAgent.save(booking)
  end

  def get(booking_id) do
    BookingAgent.get(booking_id)
  end
end
