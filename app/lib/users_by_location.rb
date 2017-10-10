class UsersByLocation
  def initialize(params)
    @state = params[:state]
    @zip = params[:zip]
    @city = params[:city]
    @lat_long = params[:lat_long]
    @radius = params[:radius] || 20
  end

  def count
    if @state.present?
      User.count_by_state @state
    elsif @zip.present?
      User.count_by_zip @zip
    elsif @city.present?
      User.count_by_location @city, @radius
    elsif @lat_long.present?
      User.count_by_location @lat_long, @radius
    else
      raise 'A city, zip code, or latitude/longitude must be provided'
    end
  end
end
