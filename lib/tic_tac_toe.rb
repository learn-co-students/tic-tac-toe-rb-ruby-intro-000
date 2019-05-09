#Win combinations in tic tac toe
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

#Empty board
board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, position)
  if board[position] == "X" || board[position] == "O"
    return true
  end
  false
end

def valid_move?(board, position)
  if position.between?(0, 9) && !position_taken?(board, position)
    return true
  end
  false
end

def turn(board)

  puts "Please enter a number between 1 and 9"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    turn(board)
  end

  display_board(board)
end


def turn_count(board)
  counter = 0
  board.each do |play|
    if play == "X" || play == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn = turn_count(board).even? ? "X" : "O"
end

def won?(board)
   WIN_COMBINATIONS.each do |win_combination|
     win_index_1 = win_combination[0]
     win_index_2 = win_combination[1]
     win_index_3 = win_combination[2]

     position_1 = board[win_index_1] # value of board at win_index_1
     position_2 = board[win_index_2] # value of board at win_index_2
     position_3 = board[win_index_3] # value of board at win_index_3

     if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_2)
       return win_combination
     end
   end
   false
end

def full?(board)
  board.all? {|i| i == "X" || i == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
   return true
  end
  false
end

def over?(board)
  if draw?(board) || won?(board) || full?(board)
   return true
  end
  false
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
     turn(board)
  end
  if won?(board)
     winner(board) == "X" || winner(board) == "O"
     puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
     puts "Cat's Game!"
  end
end
