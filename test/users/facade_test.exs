defmodule Exflight.Users.FacadeTest do
  use ExUnit.Case

  alias Exflight.Users.Facade, as: UserFacade

  alias Exflight.Users.Agent, as: UserAgent

  describe "create/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "saves the user" do
      user = %{name: "Grhamm", email: "grhamm@email.com", cpf: "12345678900"}

      response = UserFacade.create(user)

      assert {:ok, _id} = response
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      user = %{name: "Grhamm", email: "grhamm@email.com", cpf: "12345678900"}

      {:ok, id} = UserFacade.create(user)

      {:ok, id: id}
    end

    test "when the id exists, returns the user", %{id: id} do
      response = UserFacade.get(id)

      expected_response =
        {:ok,
         %Exflight.Users.User{
           cpf: "12345678900",
           email: "grhamm@email.com",
           id: id,
           name: "Grhamm"
         }}

      assert response == expected_response
    end

    test "when the id doesn't exists, return error" do
      response = UserFacade.get("banana")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
