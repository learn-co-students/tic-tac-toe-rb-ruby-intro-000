# WIN_COMBINATIONS
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

# play method
def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

# display_board method
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

board = [" "," "," "," "," "," "," "," "," "]

# input_to_index method
def input_to_index(input)
  input.to_i - 1
end

# move method
def move(board, index, character)
  board[index] = character
end

# position_taken? method
def position_taken?(board,index)
  if board[index] == " "
    return false
  elsif board[index] == ""
    return false
  elsif board[index] == nil
    return false
  else board[index] == "X" || board[index] == "O"
    return true
  end
end

# valid_move? method
def valid_move?(board,index)
  if position_taken?(board,index) == false && index.between?(0,8)
    return true
  end
end

# turn method
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# turn_count method
def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  return counter
end

# current_player method
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

# won? method
def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
  end
end

# full? method
def full?(board)
  #use detect method - example
  if board.detect{|i| i == " " || i == nil}
    return false
  else
    return true
  end
end

# draw? method
def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    false
  end
end

# over? method
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    false
  end
end

# winner method
def winner(board)
  if win_combination = won?(board)
    board[win_combination.first]
  end
end
