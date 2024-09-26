class TicTacToe
  def initialize(board=nil)
    @board = Array.new(9,' ')
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8]
  ]

  def won?
    WIN_COMBINATIONS.each do |combo|
      if @board[combo[0]] == @board[combo[1]] && @board[combo[0]] == @board[combo[2]] && (@board[combo[0]] == "X" || @board[combo[0]] == "O")
        return combo
      end
    end
    return FALSE
  end

  def full?
    @board.detect{|cell| cell == " "} ? FALSE : TRUE
  end

  def draw?
    !won?&&full?
  end

  def over?
    won?||draw?
  end

  def winner
    if over? && !draw?
      return (current_player == "X") ? "O" : "X"
    else
      return nil
    end
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(location)
    @board[location] == "X" || @board[location] == "O"
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def current_player
    return (turn_count % 2 == 0) ? "X" : "O"
  end

  def turn_count
    count = 0
    @board.each do |cell|
      if cell=="X" || cell=="O"
        count +=1
      end
    end
    return count
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
