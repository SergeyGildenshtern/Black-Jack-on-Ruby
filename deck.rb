class Deck
  def initialize
    @cards = []
    create_deck
  end

  def give_card
    @cards.delete(@cards.sample)
  end

  private
  def create_deck
    names = %w[2 3 4 5 6 7 8 9 10 J Q K A]
    suits = %W[\u2660 \u2663 \u2665 \u2666]
    names.each do |name|
      suits.each { |suit| @cards << name + suit }
    end
  end
end