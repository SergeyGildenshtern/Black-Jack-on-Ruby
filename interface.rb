require_relative 'dealer'
require_relative 'user'
require_relative 'deck'

class Interface
  def initialize
    @dealer = Dealer.new
    @user = User.new
  end

  def start
    input_name
    game_preparation
  end

  private
  def input_name
    print "Введите ваше имя:"
    @user_name = gets.chomp
    puts "Здравствуйте, #{@user_name}"
  end

  def make_bets
    puts "\nИгроки делают ставки по 10$"
    if @dealer.make_bet.nil?
      puts "У соперника недостаточно денег!"
      game_over
    else
      if @user.make_bet.nil?
        puts "Недостаточно денег!"
        game_over
      else
        game
      end
    end
  end

  def game_preparation
    distribute_cards
    make_bets
  end

  def game
    if full_hands?
      open_cards
    else
      puts "\nВаши очки: #{@user.points}"
      show_cards

      puts "\nВыберите действие:"
      puts "1) Пропустить ход"
      puts "2) Добавить карту"
      puts "3) Открыть карты"
      puts "4) Завершить игру"

      case gets.chomp
      when '1'
        dealer_move
        game
      when '2'
        add_card
        game
      when '3'
        open_cards
      when '4'
      else
        puts "Неизвестная команда!"
        game
      end
    end
  end

  def distribute_cards
    @deck = Deck.new
    2.times { @user.take_card(@deck) }
    2.times { @dealer.take_card(@deck) }
  end

  def show_cards
    print "Ваши карты:"
    @user.cards.each { |card| print " #{card} "}
    puts "\n---------------------"
    print "Карты соперника:"
    @dealer.cards.each { |card| print" ** "}
  end

  def dealer_move
    @dealer.move(@deck)
  end

  def add_card
    @user.take_card(@deck)
    dealer_move
  end

  def full_hands?
    if @user.cards.size > 2 && @dealer.cards.size > 2
      true
    else
      false
    end
  end

  def open_cards
    print "\nВаши карты:"
    @user.cards.each { |card| print " #{card} "}
    puts "\n---------------------"
    print "Карты соперника:"
    @dealer.cards.each { |card| print " #{card} "}
    take_stock
  end

  def take_stock
    puts "\nВы набрали #{@user.points} очков"
    puts "Соперник набрал #{@dealer.points} очков"

    if (21 - @user.points).abs < (21 - @dealer.points).abs
      puts 'Вы выиграли!'
      @user.win
      @dealer.lose
    elsif (21 - @user.points).abs > (21 - @dealer.points).abs
      puts 'Вы проиграли!'
      @dealer.win
      @user.lose
    else
      puts 'Ничья'
      @dealer.return_bets
      @user.return_bets
    end

    continue_game
  end

  def continue_game
    puts "\nХотите продолжить игру?"
    puts "1) Да"
    puts "2) Нет"

    case gets.chomp
    when "1"
      game_preparation
    when "2"
      game_over
    else
      raise "Неизвестная команда!"
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def game_over
    puts "\nИгра окончена! Ваш итоговый банк: #{@user.bank}$"
    puts "До свидания, #{@user_name}"
  end
end