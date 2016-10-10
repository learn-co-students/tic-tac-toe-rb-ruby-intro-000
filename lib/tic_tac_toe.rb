WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],
                    [0,3,6],[1,4,7],[2,5,8],
                    [0,4,8],[2,4,6]]

def display_board(board)
  puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index_position, symbol)
  board[index_position] = symbol
end

def position_taken?(board, position)
  board[position] == " " ? false : true
end

def valid_move?(board, position)
  position.between?(0,8) && !position_taken?(board, position) ? true : false
end

def turn(board)
  puts("Enter your position")
  user_input = gets
  index_position = input_to_index(user_input)
  if valid_move?(board, index_position)
    move(board, index_position, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.reject{|slot| slot == " " }.size
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    (board[win_combo[0]]  == "X" && board[win_combo[1]]  == "X" && board[win_combo[2]]  == "X" ||
    board[win_combo[0]]  == "O" && board[win_combo[1]]  == "O" && board[win_combo[2]] == "O")
  end
end

def full?(board)
  board.any?{|item| item == " "} ? false : true
end

def draw?(board)
  won?(board) == nil && full?(board) == true ? true : false
end

def over?(board)
  draw?(board) || won?(board) ? true : false
end

def winner(board)
  if over?(board) && won?(board)
    winning_board = won?(board)
    board[winning_board[0]] == "X" ? "X" : "O"
  elsif draw?(board)
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end

end
