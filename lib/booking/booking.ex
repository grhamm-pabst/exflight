defmodule Exflight.Bookings.Booking do
  @keys [:id, :date, :origin_city, :destination_city, :user_id]
  @enforce_keys @keys

  defstruct @keys

  def build(origin_city, destination_city, user_id) do
    id = UUID.uuid4()

    {:ok,
     %__MODULE__{
       id: id,
       date: NaiveDateTime.local_now(),
       origin_city: origin_city,
       destination_city: destination_city,
       user_id: user_id
     }}
  end
end
