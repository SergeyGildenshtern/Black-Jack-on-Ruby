class Player
  attr_reader :points, :cards

  def initialize
    @bank = 100
    @points = 0
    @cards = []
  end

  def take_card(deck)
    @cards << deck.get_card
    update_points
  end

  def make_bet
    if @bank > 0
      @bank -= 10
    else
      puts "Недостаточно денег!"
    end
  end

  def get_win
    @bank += 20
    restore_values
  end

  def restore_values
    @points = 0
    @cards = []
  end

  private
  def update_points
    card = @cards.last[0..-2]

    if card == 'Q' || card == 'J' || card == 'K'
      @points += 10
    elsif card == 'A'
      if (21 - (@points + 11)).abs < (21 - (@points + 1)).abs
        @points += 11
      else
        @points += 1
      end
    else
      @points += card.to_i
    end
  end
end
