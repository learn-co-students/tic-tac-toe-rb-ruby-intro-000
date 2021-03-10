WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#converts user input to array index
def input_to_index(user_input)
  user_input.to_i - 1
end

#assigns user input to upate the board array
def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  counter=0
  board.each do |space|
    if space =="X" || space =="O" 
      counter += 1 
    end
  end
    return counter
end

def current_player(board)
  count = turn_count(board)
  if count.even? 
    return "X"
  else
    return "O"
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
 WIN_COMBINATIONS.each do |win_combination|
  
    index_1 = win_combination[0]
    index_2 = win_combination[1]
    index_3 = win_combination[2]
    
   if board[index_1] == "X" && board[index_2] == "X" && board[index_3] == "X" || board[index_1] == "O" && board[index_2] == "O" && board[index_3] == "O"
return win_combination
  end
  end
  return false
end

def full?(board)
  full_value = board.all? { |value| value == "X" || value == "O"}
  return full_value
end

def draw?(board)
  if (!won?(board) && full?(board))
    return true 
  end
  return false
end
 
def over?(board)
  if (won?(board) || draw?(board) || full?(board))
    return true 
  end
end 

def winner(board)
  if won?(board)
  winning_combination = won?(board)
  winning_space = winning_combination[0] 
  if board[winning_space] == "X"
    return "X"
  else
    return "O"
  end
end
end

def play(board)
  until over?(board)
  turn(board)
end
if draw?(board)
  puts "Cat's Game!"
end
if won?(board)
  puts "Congratulations #{winner(board)}!"
end
end



