defmodule Exflight.Bookings.FacadeTest do
  use ExUnit.Case

  import Exflight.Factory

  alias Exflight.Bookings.Facade, as: BookingFacade

  alias Exflight.Users.Agent, as: UserAgent

  describe "create/1" do
    setup do
      Exflight.start_links()

      {:ok, user_id} = UserAgent.save(build(:user))

      {:ok, user_id: user_id}
    end

    test "when the user_id is valid, saves the flight booking", %{user_id: user_id} do
      response =
        BookingFacade.create(%{
          origin_city: "Salvador",
          destination_city: "Rio de Janeiro",
          user_id: user_id
        })

      assert {:ok, _id} = response
    end

    test "when the user_id is not valid, returns an error" do
      response =
        BookingFacade.create(%{
          origin_city: "Salvador",
          destination_city: "Rio de Janeiro",
          user_id: "banana"
        })

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      Exflight.start_links()

      {:ok, user_id} = UserAgent.save(build(:user))

      {:ok, booking_id} =
        BookingFacade.create(%{
          origin_city: "Salvador",
          destination_city: "Rio de Janeiro",
          user_id: user_id
        })

      {:ok, booking_id: booking_id}
    end

    test "when the booking id is valid, returns the flight booking", %{booking_id: booking_id} do
      response = BookingFacade.get(booking_id)

      assert {:ok,
              %Exflight.Bookings.Booking{
                date: _date,
                destination_city: "Rio de Janeiro",
                id: _id,
                origin_city: "Salvador",
                user_id: _user_id
              }} = response
    end

    test "when the booking id is not valid, returns an error" do
      response = BookingFacade.get("banana")

      expected_response = {:error, "Flight Booking not found"}

      assert response == expected_response
    end
  end
end
