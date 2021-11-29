require_relative 'player'

class Dealer < Player
  def move(deck)
    take_card(deck) if @points < 17
  end
end