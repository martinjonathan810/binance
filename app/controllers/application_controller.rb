class ApplicationController < ActionController::Base
  def index
    binance_json = binance_data
    render json: average_data_of(binance_json)
  end

  private

  def average_data_of binance_json
    total_data = [0] * 12
    binance_json.each do |binance_datum|
      binance_datum.each_with_index do |element, idx|
        total_data[idx] += element.to_f
      end
    end

    average_data = []
    total_data.each do |element|
      average_data.push(element/12)
    end

    average_data
  end

  def binance_data
    t = HTTParty.get(binance_url)
    JSON.parse(t.response.body)
  end

  def binance_url
    'https://api.binance.com/api/v3/klines?symbol=ADABNB&interval=1h'
  end
end
