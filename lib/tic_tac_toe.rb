WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8]
]
board = [" "," "," "," "," "," "," "," "," "]
def display_board(move = " ")
  row = "-----------"
  cell_one = " #{move[0]} " + "|" + " #{move[1]} " + "|" + " #{move[2]} "
  cell_two = " #{move[3]} " + "|" + " #{move[4]} " + "|" + " #{move[5]} "
  cell_three = " #{move[6]} " + "|" + " #{move[7]} " + "|" + " #{move[8]} "
puts cell_one
puts row
puts cell_two
puts row
puts cell_three
end
def input_to_index(user_input)
  position_value = user_input.to_i
  index = position_value - 1
  return index
end
def move(array, index, character)
  array[index] = character
end
def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end
def valid_move?(board, index)
  if index.between?(0, 8) && position_taken?(board, index) != true
    return true
  else
    return false
  end
end
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      puts "Invalid input"
      turn(board)
    end
end
def turn_count(board)
counter = 0
  board.each do |player|
    if player == "X" || player == "O"
      counter += 1
    end
  end
    counter
end
def current_player(board)
 up_next = turn_count(board)
 if up_next.even?
   return "X"
 else
   return "O"
 end
end
def won?(board)
  WIN_COMBINATIONS.find do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]

  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return win_combination
  else
    false
  end
end
end
def full?(board)
  if board.find {|i| i == " " || i == "" || i == nil}
    return false
  else
    return true
  end
end
def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
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
  if answer = won?(board)
    return board[answer[0]]
  end
end
def play(board)
  until over?(board)
    current_player(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
