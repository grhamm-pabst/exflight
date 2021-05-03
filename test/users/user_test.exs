defmodule Exflight.Users.UserTest do
  use ExUnit.Case
  alias Exflight.Users.User

  describe "build/1" do
    test "builds the user" do
      response = User.build("Grhamm", "grhamm@email.com", "12345678900")

      assert {:ok,
              %Exflight.Users.User{
                cpf: "12345678900",
                email: "grhamm@email.com",
                id: _id,
                name: "Grhamm"
              }} = response
    end
  end
end
