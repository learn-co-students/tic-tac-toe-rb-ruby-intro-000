Board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def move(board, index, current_player)
    board[index] = current_player
  end

  def position_taken?(board, location)
    board[location] != " " && board[location] != ""
  end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
      count = 0
      board.each do |i|
      if i == "X" || i == "O"
        count += 1
                end

      end
      return count
  end

  def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"

  end
  end

  def won?(board)
      combo = 0
      while combo < WIN_COMBINATIONS.length
        current_combo = WIN_COMBINATIONS[combo]

        win1 = current_combo.all? { |position| board[position] == "X" }
        win2 = current_combo.all? { |position| board[position] == "O" }

        if win1 == true || win2 == true
          return current_combo
        else
         false
        end

        combo += 1
      end

    end

  def full?(board)
    board.all? do |i|
      i == "X" || i == "O"
    end
  end

  def draw?(board)
    if !won?(board) && full?(board)
      return true
    else
      return false
    end
  end

  def over?(board)
    if draw?(board) || won?(board)
      return true
    else return false
    end
  end

  def winner(board)
    winner = won?(board)
    if winner != nil
      return board[winner[0]]
    end
  end

  def play(board)
  until over?(board)
    turn(board)
    end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cat's Game!"
  end

  end
