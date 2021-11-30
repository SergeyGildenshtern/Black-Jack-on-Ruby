class Card
  attr_reader :name, :suit

  def initialize(name, suit)
    @name = name
    @suit = suit
  end

  def to_s
    @name + @suit
  end
end