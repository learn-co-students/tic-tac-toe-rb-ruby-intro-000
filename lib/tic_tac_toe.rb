def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#WIN_COMBINATIONS
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

#input_to_index
def input_to_index(input)
  input.to_i - 1
end

#turn_count
def turn_count(board)
  counter = 0
  board.each do |move|
    if move == "X" || move == "O"
      counter += 1
    end
  end
  return counter
end


#current_player
def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    "X"
  else
    "O"
  end
end

#move
def move(board, index, current_player)
board[index] = current_player
end

#position_taken?
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


#valid_move?
def valid_move?(board, index)
  if (index >= 0 && index < 9) && !position_taken?(board, index)
    true
  else
    false
  end
end

#won?
def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
  win_index_1 = win_combo[0]
  win_index_2 = win_combo[1]
  win_index_3 = win_combo[2]

  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]

  if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
    (position_1 == "O" && position_2 == "O" && position_3 == "O")
    return win_combo
  end
end
    return false
end

#full?
def full?(board)
  board.all?{|position| position == "X" || position == "O"}
end

#draw?
def draw?(board)
  !won?(board) && full?(board)
end

#over?
def over?(board)
  won?(board) || draw?(board)
end

#winner
def winner(board)
  if won?(board)
  board[won?(board)[0]]
end
end

#turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board, index)
    turn(board)
  end
  move(board, index, current_player(board))
  display_board(board)
end

#play
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
