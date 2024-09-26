# Helper Methods

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
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
  counter = 0
  board.each do | turn |
    if (turn != " " )
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turns = turn_count(board)
  turn = turns % 2 == 0 ? "X" : "O"
end



def won? (board)
  WIN_COMBINATIONS.each do |win|
    if (
      (board[win[0]] != " " && board[win[1]] != " " && board[win[2]] != " ") &&
      ((board[win[0]] == board[win[1]]) && (board[win[1]] == board[win[2]]))
      )
      return win
    end
  end
  return false
end

def full?(board)
  board.none? { |e| e == " "  }
end

def draw?(board)
  if ( !won?(board) && full?(board) )
    return true
  elsif ( ! won?(board) && ! full?(board) )
    return false
  elsif won?(board)
    return false
  elsif full?(board)
    return true
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  w = won?(board)
  #binding.pry
  if w
    return board[w[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
      puts "Cat's Game!"
  end
end
