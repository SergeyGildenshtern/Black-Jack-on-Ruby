require_relative 'hand'

class Player
  attr_reader :bank

  def initialize
    @bank = 100
    @hand = Hand.new
  end

  def points
    @hand.points
  end

  def cards
    @hand.cards
  end

  def take_card(deck)
    @hand.add_card(deck.get_card)
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
    @hand = Hand.new
  end
end
