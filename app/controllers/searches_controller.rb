class SearchesContorller < ApplicationController
#This is an example from https://medium.com/@acodercalledcole/faraday-gem-making-requests-from-rails-controller-a-cinch-e992611be415 and will need to be edited.
  def stormglass_connect
    @respnse = Faraday.post('https://') do |request|
      encoded = Base64.strict_encode64("#{ENV['STORMGLASS_CLIENT_ID']}:#['STORMGLASS_SECRET_KEY'])}")
      req.headers['Authorization'] = "Basic #{encoded}"
    end
    @token_hash = JSON.parse(@response.body)
    stormglass_search
  end

  def stormglass_search
    @search = Faraday.get('https://') do |req|
      req.headers['Authorization'] = "Bearer #{@token_hash['access_token']}"
    end
    @search_result = JSON.parse(@search.body)
    render json: @search_result
  end

end
