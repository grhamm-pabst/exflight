defmodule Exflight.Reports.Report do
  alias Exflight.Bookings.Agent, as: BookingAgent
  alias Exflight.Bookings.Booking

  def build({:ok, from_date}, {:ok, to_date}) do
    report_list = report_list_builder(from_date, to_date)
    File.write("report.csv", report_list)
  end

  defp report_list_builder(from_date, to_date) do
    BookingAgent.list_all()
    |> Enum.map(fn line -> date_filter(line, from_date, to_date) end)
  end

  defp date_filter({_id, %Booking{date: date} = booking}, from_date, to_date) do
    if is_date_greater?(date, from_date) and is_date_greater?(to_date, date) do
      booking
      |> line_builder()
    else
      ""
    end
  end

  defp is_date_greater?(date1, date2) do
    case NaiveDateTime.compare(date1, date2) do
      :gt -> true
      _ -> false
    end
  end

  defp line_builder(%Booking{
         date: date,
         user_id: user_id,
         origin_city: origin_city,
         destination_city: destination_city
       }) do
    "#{user_id},#{origin_city},#{destination_city},#{date}\n"
  end
end
