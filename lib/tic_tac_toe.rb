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
  index = user_input.to_i - 1
end

def move(board, index, player_character)
  board[index] = "#{player_character}"
end

def position_taken?(board, index)
  if board[index] == " " ||
    board[index] == "" ||
    board[index] == nil
  then false
  elsif board[index] == "X" ||
    board[index] == "O"
  then true
  end
end

def valid_move?(board, index)
  if index.between?(0,8) && !(position_taken?(board, index))
  then true
  end  
end

def turn(board) # individual turn of play
  puts "Please enter 1-9:"
  user_input = gets
  index = input_to_index(user_input)
  if !valid_move?(board, index)
    turn(board)
  else
    current_player = current_player(board)
    move(board, index, current_player)
  end
  display_board(board)
end

def turn_count(board)
  turn = 0
  board.each do |space|
    if space == "X" || space == "O"
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  if turn_count(board).even?
    then current_player = "X"
  else
    current_player = "O"
  end
end

def won?(board)
   if empty?(board)
     return false
   end
   
  WIN_COMBINATIONS.each do |win_combination|
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
    end
   end
   
   if full?(board)
     return false
   end
   
   return false
 end

 def full?(board)
   if position_taken?(board, 0) &&
     position_taken?(board, 1) &&
     position_taken?(board, 2) &&
     position_taken?(board, 3) &&
     position_taken?(board, 4) &&
     position_taken?(board, 5) &&
     position_taken?(board, 6) &&
     position_taken?(board, 7) &&
     position_taken?(board, 8)
     return true
   end
 end
 
 def empty?(board)
   if !position_taken?(board, 0) &&
     !position_taken?(board, 1) &&
     !position_taken?(board, 2) &&
     !position_taken?(board, 3) &&
     !position_taken?(board, 4) &&
     !position_taken?(board, 5) &&
     !position_taken?(board, 6) &&
     !position_taken?(board, 7) &&
     !position_taken?(board, 8)
     return true
   end
 end

 def draw?(board)
   if full?(board) && won?(board) == false
     return true
   else
     return false
   end
 end

 def over?(board)
   if draw?(board)
     return true
   elsif won?(board) != false
     return true
   end
 end

 def winner(board)
   if won?(board) == false
     return nil
   else
     return board[won?(board)[0]]
   end
 end
 
 def play(board)
   until over?(board)
    turn(board)
   end
   if won?(board) != false
     puts "Congratulations #{winner(board)}!"
   end
   if draw?(board)
     puts "Cat's Game!"
   end
 end