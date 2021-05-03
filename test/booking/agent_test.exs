defmodule Exflight.Bookings.AgentTest do
  use ExUnit.Case

  import Exflight.Factory

  alias Exflight.Users.User

  alias Exflight.Bookings.Agent, as: BookingAgent

  describe "save/1" do
    setup do
      Exflight.start_links()

      %User{name: name, email: email, cpf: cpf, id: user_id} = build(:user)

      Exflight.create_user(%{name: name, email: email, cpf: cpf})

      {:ok, user_id: user_id}
    end

    test "saves the flight booking", %{user_id: user_id} do
      booking = build(:booking, %{user_id: user_id})
      response = BookingAgent.save(booking)

      assert {:ok, _id} = response
    end
  end

  describe "get/1" do
    setup do
      Exflight.start_links()

      %User{name: name, email: email, cpf: cpf} = build(:user)

      {:ok, user_id} = Exflight.create_user(%{name: name, email: email, cpf: cpf})

      booking = build(:booking, %{user_id: user_id})

      {:ok, booking_id} = BookingAgent.save(booking)

      {:ok, user_id: user_id, booking_id: booking_id, booking: booking}
    end

    test "when the id is valid, returns booking", %{booking_id: booking_id, booking: booking} do
      response = BookingAgent.get(booking_id)

      expected_response = {:ok, booking}

      assert response == expected_response
    end

    test "when the id is invalid, returns an error" do
      response = BookingAgent.get("banana")

      expected_response = {:error, "Flight Booking not found"}

      assert response == expected_response
    end
  end

  describe "list_all/0" do
    setup do
      Exflight.start_links()

      %User{name: name, email: email, cpf: cpf} = build(:user)

      {:ok, user_id} = Exflight.create_user(%{name: name, email: email, cpf: cpf})

      booking = build(:booking, %{user_id: user_id})

      {:ok, booking_id} = BookingAgent.save(booking)

      {:ok, booking_id: booking_id, booking: booking}
    end

    test "returns all flight booking records on agent", %{
      booking_id: booking_id,
      booking: booking
    } do
      response = BookingAgent.list_all()

      expected_response = %{
        booking_id => booking
      }

      assert response == expected_response
    end
  end
end
