module ApplicationHelper

  def pretty_datetime(datetime_item)
    datetime_item.to_s.chomp('UTC')
  end

  def pretty_price(price)
    number_to_currency(price, precision: 0, delimiter: " ", format: "%n %u" , locale: :ru, unit: "р.")
  end

end
