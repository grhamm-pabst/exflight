defmodule Exflight.Bookings.BookingTest do
  use ExUnit.Case

  import Exflight.Factory

  alias Exflight.Bookings.Booking
  alias Exflight.Users.User

  describe "build/1" do
    test "builds the flight booking" do
      %User{id: id} = build(:user)

      response = Booking.build("Salvador", "Rio de Janeiro", id)

      assert {:ok,
              %Exflight.Bookings.Booking{
                date: _date,
                destination_city: "Rio de Janeiro",
                id: _id,
                origin_city: "Salvador",
                user_id: _user_id
              }} = response
    end
  end
end
