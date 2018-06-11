WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
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

def move(board, index, token)
  board[index] = token
end

def position_taken? (board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move? (board, position)
  if position.between?(0, 8) &&  position_taken?(board, position) == false
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  token = current_player(board)
  position = input_to_index(gets)
  if valid_move?(board, position)
    move(board, position, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = board.select{|token| token == "X" || token == "O"}
  return turns.length
end

def current_player(board)
  if turn_count(board).odd?
    return "O"
  else
    return "X"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_combination.all?{|win_index| board[win_index] == "X"} || win_combination.all?{|win_index| board[win_index] == "O"}
  end
end

def full?(board)
  turn_count(board) >= 9
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board).kind_of?(Array)
    winning_array = won?(board).first
    board[winning_array]
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
