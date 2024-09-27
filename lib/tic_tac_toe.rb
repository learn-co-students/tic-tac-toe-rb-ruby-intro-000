require "pry"
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
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
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    return move(board, index, current_player(board))
    display_board(board)
#binding.pry
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |board_index|
    if board_index == "X" || board_index == "O"
    counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |winning_array|
    board[winning_array[0]] == board[winning_array[1]] && board[winning_array[1]] == board[winning_array[2]] && position_taken?(board, winning_array[0])
  end
end


def full?(board)
  board.all? do |each_index|
#binding.pry
    each_index == "X" || each_index == "O"
  end
  end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  combo_array = won?(board)
    if combo_array
      return board[combo_array[0]] #in a winning combo the tokens match so [0] or [1] [2] will all give the same result
    end
    return nil
end

def play(board)
  until over?(board)
      turn(board)
  end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    else
      puts "Cat's Game!"
    end

end
