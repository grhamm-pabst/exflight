defmodule Exflight.Factory do
  use ExMachina

  alias Exflight.Bookings.Booking
  alias Exflight.Users.User

  def user_factory do
    %User{
      id: UUID.uuid4(),
      name: "Grhamm",
      email: "grhamm@email.com",
      cpf: "12345678900"
    }
  end

  def booking_factory do
    {:ok, date} = NaiveDateTime.new(2021, 5, 1, 21, 45, 23)

    %Booking{
      id: UUID.uuid4(),
      date: date,
      origin_city: "Salvador",
      destination_city: "Rio de Janeiro",
      user_id: UUID.uuid4()
    }
  end
end
