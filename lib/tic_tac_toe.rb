# Helper methods

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

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

# def input_to_index (input)
#   index = input.to_i - 1
# end

def input_to_index (input)
  input.to_i - 1
end

def move(board, position, token)
  board[position] = token
end

def valid_move?(board, position)
  # if (index.between(0,8) && !position_taken(board, index))
  position.between?(0,8) && !position_taken?(board, position)
end

def turn_count(board)
  # turns = 0
  #   board.each do |token|
  #     if (token  == "X" || token == "O")
  #       turns += 1
  #     end
  #   end
  # turns
   board.count { |token| token == 'X' || token == 'O' }
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index (user_input)
  if valid_move?(board, index)
    # current_player_token = current_player(board)
    # move(board, index, current_player_token)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "Invalid move"
    puts "Please put postion (1-9)"
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.detect { |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
   }
end

def full?(board)
  board.all? { |token|
    token == "X" || token == "O"
  }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  # won?(board) || draw?(board) || full?(board)
   won?(board) || draw?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

# def play(board)
#   until over?(board)
#     turn(board)
#   end
#   if won?(board)
#     winner_token = winner(board)
#     puts "Congratulations #{winner_token}!"
#   elsif draw?(board)
#     puts "Cat\'s Game!"
#   end
# end

def play(board)
  turn(board) until over?(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
