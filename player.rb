class Player
  attr_reader :points, :cards, :bank

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
    @bank -= 10 if @bank > 0
  end

  def win
    @bank += 20
    restore_values
  end

  def lose
    restore_values
  end

  def return_bets
    @bank += 10
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
      if @points + 11 <= 21
        @points += 11
      else
        @points += 1
      end
    else
      @points += card.to_i
    end
  end
end
