defmodule Exflight.Users.AgentTest do
  use ExUnit.Case

  import Exflight.Factory

  alias Exflight.Users.User

  alias Exflight.Users.Agent, as: UserAgent

  describe "save/1" do
    setup do
      UserAgent.start_link(%{})

      %User{name: name, email: email, cpf: cpf, id: id} = build(:user)
      user = %User{name: name, email: email, cpf: cpf, id: id}

      {:ok, id: id, user: user}
    end

    test "saves the user", %{user: user} do
      response = UserAgent.save(user)

      assert {:ok, _id} = response
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      user = build(:user)

      {:ok, id} = UserAgent.save(user)

      {:ok, id: id, user: user}
    end

    test "when the id exists, returns the user", %{id: id} do
      response = UserAgent.get(id)

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

    test "when the id doesn't exists, returns error" do
      response = UserAgent.get("banana")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end

  describe "list_all/0" do
    setup do
      UserAgent.start_link(%{})

      user = build(:user)

      {:ok, id} = UserAgent.save(user)

      {:ok, id: id}
    end

    test "returns the list of users stored in the agent", %{id: id} do
      response = UserAgent.list_all()

      expected_response = %{
        id => %Exflight.Users.User{
          cpf: "12345678900",
          email: "grhamm@email.com",
          id: id,
          name: "Grhamm"
        }
      }

      assert expected_response == response
    end
  end
end
