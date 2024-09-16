# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8],  # horizontal (top, mid, bottom)
  [0,4,8],[2,4,6],[0,3,6],  # vertical (left, mid, right)
  [1,4,7],[2,5,8]           # diaganols
]

# Helper Methods

def display_board(board)
  puts
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  return !(won?(board)) && full?(board)
end

def over?(board)
  return won?(board) || draw?(board) || full?(board)
end

def move(board, index, current_player)
  board[index] = current_player
end

def turn(board)
  puts "Please enter 1-9:  "
  input = input_to_index(gets.strip)
  if !valid_move?(board, input)
    turn(board)
  else
    move(board, input, current_player(board))
    display_board(board)
  end
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def position_taken?(board, location)
  if !(board[location].nil? || board[location] == " " || board[location] == "")
    # puts("Position take, try another position!")
    return true  # position is taken
  else
    return false   # position is not taken; ok to use
  end
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if (position_1 == "X" || position_1 == "O") && (position_1 == position_2) && (position_1 == position_3)
      return (win_combination) # return the win_combination indexes that won.
    else
      false
    end
  end
  if false
    return false
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts("Cat\'s Game!")
  elsif winner(board) == "X"
    puts("Congratulations X!")
  elsif winner(board) == "O"
    puts("Congratulations O!")
  else
    puts("what's going on?")
  end
end

def winner(board)                 # returns winner "X" or "O" or nil for no winner
  if (won?(board) == nil)
    return(won?(board))
  else
    won?(board).each do |cells|
      return board[cells]
    end
  end
end

=begin
board = ['X', ' ', ' ', ' ', 'X', ' ', ' ', ' ', 'X']
board = [" ", " ", "X", " ", "X", " ", "X", " ", " "]
display_board(board)
puts(won?(board))
puts(winner(board))
puts(draw?(board))
puts(full?(board))
puts("over?  #{over?(board)}, !!!")

board = [" ", " ", " ", " ", " ", " ", "O", "O", "O"]
display_board(board)
puts(won?(board))
puts(winner(board))
puts(draw?(board))
puts(full?(board))
puts("over?  #{over?(board)}, !!!")

board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
display_board(board)
puts(won?(board))
puts(draw?(board))
puts(full?(board))
puts("over?  #{over?(board)}, !!!")
=end
