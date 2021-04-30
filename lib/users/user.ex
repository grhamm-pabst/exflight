defmodule Exflight.Users.User do
  @keys [:id, :name, :email, :cpf]
  @enforce_keys @keys

  defstruct @keys

  def build(name, email, cpf) do
    id = UUID.uuid4()

    {:ok,
     %__MODULE__{
       id: id,
       name: name,
       email: email,
       cpf: cpf
     }}
  end
end
