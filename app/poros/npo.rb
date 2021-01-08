class Npo
  attr_reader :ein, :name, :city, :state

  def initialize(data)
    @ein = data[:ein]
    @name = data[:name]
    @city = data[:city]
    @state = data[:state]
  end
end