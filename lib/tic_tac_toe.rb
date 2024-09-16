#board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

WIN_COMBINATIONS = [
  [0,1,2], #Top Row
  [3,4,5], #Mid Row
  [6,7,8], #Bottom Row
  [0,4,8], #Diagonal L>R
  [2,4,6], #Diagonal R>L
  [0,3,6], #L Column
  [1,4,7], #Mid Column
  [2,5,8]  #R Column
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input = input.to_i
  input - 1
end

def move(board, index, player_character)
  board[index] = player_character
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  turn_counter = 0
  index_number = 0
  board.each do
    if board[index_number] != " "
      turn_counter += 1
    end
    index_number += 1
  end
  turn_counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player_character = current_player(board)
  if valid_move?(board, index)
    move(board, index, player_character)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
win_combo = false
  WIN_COMBINATIONS.each do |win_array|
    if board[win_array[0]] == "X" && board[win_array[1]] == "X" && board[win_array[2]] == "X" || board[win_array[0]] == "O" && board[win_array[1]] == "O" && board[win_array[2]] == "O"
      win_combo = win_array
    end
  end
win_combo
end

def full?(board)
  full = false
  if board[0] != " " && board[1] != " " && board[2] != " " && board[3] != " " && board[4] != " " && board[5] != " " && board[6] != " " && board[7] != " " && board[8] != " "
    full = true
  end
  full
end

def draw?(board)
  full?(board) && !won?(board)
end

#def draw?(board)
#  if full?(board) && won?(board)
#    false
#  elsif full?(board) && !won?(board)
#    true
#  else !full?(board)
#    false
#  end
#end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  winner = nil
  WIN_COMBINATIONS.each do |win_array|
    if board[win_array[0]] == "X" && board[win_array[1]] == "X" && board[win_array[2]] == "X"
      winner = "X"
    elsif board[win_array[0]] == "O" && board[win_array[1]] == "O" && board[win_array[2]] == "O"
      winner = "O"
    end
  end
  winner
end

def play(board)
  until over?(board)
    turn(board)
  end

  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

#winner(board)

#  if over?(board) && winner(board) = "X"
#    puts "Congratulations X!"
#  elsif over?(board) && winner(board) = "O"
#    puts "Congratulations O!"
#  elsif over?(board) && draw?(board)
#    puts "Cat's Game!"
#  end
#end







#def play(board)
#  counter = 0
#  until counter == 9
#    turn(board)
#    counter += 1
#  end
#end
