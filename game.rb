require_relative 'interface'
require_relative 'dealer'
require_relative 'user'
require_relative 'deck'

class Game
  def initialize
    @user = User.new
    @dealer = Dealer.new
    @interface = Interface.new(@user, @dealer)
  end

  def start
    @interface.input_name
    game_preparation
  end

  private
  def distribute_cards
    @deck = Deck.new
    2.times { @user.take_card(@deck) }
    2.times { @dealer.take_card(@deck) }
  end

  def make_bets
    if @dealer.make_bet.nil?
      @interface.not_enough_money(Dealer)
      @interface.game_over
    else
      if @user.make_bet.nil?
        @interface.not_enough_money(User)
        @interface.game_over
      else
        play
      end
    end
  end

  def game_preparation
    distribute_cards
    make_bets
  end

  def play
    if full_hands?
      open_cards
      continue_game
    else
      @interface.show_score
      @interface.show_cards

      case @interface.show_menu
      when '1'
        dealer_move
        play
      when '2'
        add_card
        dealer_move
        play
      when '3'
        open_cards
        continue_game
      when '4'
        @interface.game_over
      else
        puts "Неизвестная команда!"
        play
      end
    end
  end

  def full_hands?
    if @user.cards.size > 2 && @dealer.cards.size > 2
      true
    else
      false
    end
  end

  def dealer_move
    @dealer.move(@deck)
  end

  def add_card
    @user.take_card(@deck)
  end

  def open_cards
    @interface.open_cards
    @interface.take_stock

    if @user.points > @dealer.points && @user.points <= 21
      win
      @interface.win
    elsif @dealer.points > @user.points && @dealer.points <= 21
      lose
      @interface.lose
    elsif @user.points == @dealer.points
      draw
      @interface.draw
    elsif @user.points - @dealer.points < 0
      win
      @interface.win
    else
      lose
      @interface.lose
    end
  end

  def win
    @user.win
    @dealer.lose
  end

  def lose
    @user.lose
    @dealer.win
  end

  def draw
    @dealer.return_bets
    @user.return_bets
  end

  def continue_game
    case @interface.continue_game
    when "1"
      game_preparation
    when "2"
      @interface.game_over
    else
      raise "Неизвестная команда!"
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end
end
