class CitysController < ApplicationController
  def get_states_by_city
    if City.find(params[:city_id]).present?
      city = City.find(params[:city_id])
      @states = city.states
    end

    render json: {states: @states}
  end
end
