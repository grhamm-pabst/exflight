defmodule Exflight.Reports.ReportTest do
  use ExUnit.Case

  import Exflight.Factory

  alias Exflight.Users.User

  alias Exflight.Bookings.Agent, as: BookingAgent

  describe "build/1" do
    test "builds the report" do
      Exflight.start_links()

      %User{id: user_id, name: name, email: email, cpf: cpf} = build(:user)

      Exflight.create_user(%{name: name, email: email, cpf: cpf})

      build_list(2, :booking, user_id: user_id)
      |> Enum.map(fn booking -> BookingAgent.save(booking) end)

      Exflight.generate_report(
        NaiveDateTime.new(2020, 05, 12, 23, 56, 12),
        NaiveDateTime.new(2021, 09, 12, 23, 56, 12)
      )

      response = File.read!("report.csv")

      expected_response =
        "#{user_id},Salvador,Rio de Janeiro,2021-05-01 21:45:23\n" <>
          "#{user_id},Salvador,Rio de Janeiro,2021-05-01 21:45:23\n"

      assert response == expected_response
    end
  end
end
