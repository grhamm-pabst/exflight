defmodule Exflight.Users.Facade do
  alias Exflight.Users.Agent, as: UserAgent
  alias Exflight.Users.User

  def create(%{name: name, email: email, cpf: cpf}) do
    User.build(name, email, cpf)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)
  end

  def get(user_id) do
    UserAgent.get(user_id)
  end
end
