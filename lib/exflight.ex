defmodule Exflight do
  alias Exflight.Bookings.Agent, as: BookingAgent
  alias Exflight.Bookings.Facade, as: BookingFacade
  alias Exflight.Users.Agent, as: UserAgent
  alias Exflight.Users.Facade, as: UserFacade

  def start_links() do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate create_user(params), to: UserFacade, as: :create
  defdelegate get_user(params), to: UserFacade, as: :get

  defdelegate create_booking(params), to: BookingFacade, as: :create
  defdelegate get_booking(params), to: BookingFacade, as: :get
end
