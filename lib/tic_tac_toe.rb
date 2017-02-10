
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

def display_board(board)
 puts " #{board[0]} | #{board[1]} | #{board[2]} "
 puts "-----------"
 puts " #{board[3]} | #{board[4]} | #{board[5]} "
 puts "-----------"
 puts " #{board[6]} | #{board[7]} | #{board[8]} "
 end

 def input_to_index(user_input)
   user_input = user_input.to_i - 1
 end

 def move(board, index, value)
   board[index] = value
 end

 def position_taken?(board, index)
 if board[index] == nil || board[index] == "" || board[index] == " "
   return false
 else
   return true
 end
 end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0,8)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp
  index = input_to_index(user_input)
  if valid_move?(board, index)
  move(board, index, current_player(board))
  display_board(board)
  else
    turn(board)
  end
end

 def turn_count(board)
   count = 0
   board.each do |element|
    if element != "" && element != " " && element != nil
     count += 1
   end
   end
   count
 end



def current_player(board)
  counter = turn_count(board)
  if counter % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
  return win_combo  if position_taken?(board, win_combo[0]) &&
                       board[win_combo[0]] == board[win_combo[1]] &&
                       board[win_combo[1]] == board[win_combo[2]]
end
  return false
end

def full?(board)
  board.each do |element|
  return false if element == "" || element == " " || element == nil
end
  return true
end

def draw?(board)
  if won?(board) || !full?(board)
    false
  else
    true
  end
end

def over?(board)
   won?(board) || draw?(board) || full?(board)
 end

def winner(board)
  if won?(board)
    win_person = won?(board)
    return board[win_person[0]]
  end
  return nil
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
