def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(number)
  number.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def valid_move?(board, index)
  if index >= 0 && index <= 8 && (board[index] != "X" && board[index] != "O")
    true
  end
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == ""
    false
  elsif board[index] == nil
    false
  else
    true
  end
end

def turn(board)
  puts "Select a number between 1-9 to make a move. 1 = top left and 9 = bottom right"
  choice = gets.strip.to_i-1
  input_to_index(choice)
  value = current_player(board)
  if valid_move?(board, choice)
    move(board, choice, value)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  board.count {|board| board == "X" || board == "O"}
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

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

def won?(board)
  WIN_COMBINATIONS.detect do |win_position|
    board[win_position[0]] == board[win_position[1]] && board[win_position[1]] == board[win_position[2]] && position_taken?(board,win_position[0])
  end
end

def full?(board)
  board.all? do |taken|
    taken == "X" || taken == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def play(board)
until over?(board)
  turn(board)
end
if draw?(board)
  puts "Cats Game!"
elsif won?(board)
  puts "Congratulations #{winner(board)}!"
end
end
