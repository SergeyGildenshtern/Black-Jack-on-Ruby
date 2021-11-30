class Hand
  attr_reader :points, :cards

  def initialize
    @cards = []
    @points = 0
  end

  def add_card(card)
    @cards << card
    update_points
  end

  private
  def update_points
    name = @cards.last.name

    if name == 'Q' || name == 'J' || name == 'K'
      @points += 10
    elsif name == 'A'
      if @points + 11 <= 21
        @points += 11
      else
        @points += 1
      end
    else
      @points += name.to_i
    end
  end
end