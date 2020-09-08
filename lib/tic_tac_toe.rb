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

board = [" "," "," "," "," "," "," "," "," "]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, user_input,character)
  board[user_input] = character
end

def position_taken?(board,index)
  if(board[index] == " " || board[index] == "" )
    return false
    elsif(board[index] == nil)
    return false
  end
  true
end

def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board,index)
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
  if turn_count(board) % 2 == 0
   return "X"
 else
   "O"
 end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board)) 
    display_board(board)
  else
    turn(board)
  end
end

 def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
   
    if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
      return win_combo
    end
  end
  return false
end

def full?(board)
  if board.any? {|index| index == "nil" || index == " "}
    return false
  else
    return true
  end
end

def draw?(board)
   if !won?(board) && full?(board)
     return true
  else won?(board)
     return false
   end
end
  
 def over?(board)
  if draw?(board) || won?(board) || full?(board) 
    return true
  else
    return false
  end
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
  else draw?(board)
    puts "Cat\'s Game!"
  end
end








 

