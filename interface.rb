class Interface
  def initialize(user, dealer)
    @user = user
    @dealer = dealer
  end

  def input_name
    print "Введите ваше имя:"
    @user_name = gets.chomp
    puts "Здравствуйте, #{@user_name}"
  end

  def make_bets
    puts "\nИгроки делают ставки по 10$"
  end

  def not_enough_money(player)
    if player == Dealer
      puts "У соперника недостаточно денег!"
    elsif player == User
      puts "Недостаточно денег!"
    end
  end

  def show_score
    puts "\nВаши очки: #{@user.points}"
  end

  def show_cards
    print "Ваши карты:"
    @user.cards.each { |card| print " #{card.to_s} " }
    puts "\n---------------------"
    print "Карты соперника:"
    @dealer.cards.size.times { print" ** " }
  end

  def show_menu
    puts "\nВыберите действие:"
    puts "1) Пропустить ход"
    puts "2) Добавить карту"
    puts "3) Открыть карты"
    puts "4) Завершить игру"
    gets.chomp
  end

  def open_cards
    print "\nВаши карты:"
    @user.cards.each { |card| print " #{card.to_s} "}
    puts "\n---------------------"
    print "Карты соперника:"
    @dealer.cards.each { |card| print " #{card.to_s} "}
  end

  def take_stock
    puts "\nВы набрали #{@user.points} очков"
    puts "Соперник набрал #{@dealer.points} очков"
  end

  def win
    puts "Вы выиграли!"
  end

  def lose
    puts "Вы проиграли!"
  end

  def draw
    puts "Ничья"
  end

  def continue_game
    puts "\nХотите продолжить игру?"
    puts "1) Да"
    puts "2) Нет"
    gets.chomp
  end

  def game_over
    puts "\nИгра окончена! Ваш итоговый банк: #{@user.bank}$"
    puts "До свидания, #{@user_name}"
  end
end