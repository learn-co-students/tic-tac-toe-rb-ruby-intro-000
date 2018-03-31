

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]]
  
def won?(board)
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
  
    return false
end 

board = ["   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   "]
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

def move(array, index, value)
  array[index] = value
end

def valid_move?(board, index)
  if position_taken?(board, index)
  
  else index.between?(0, 8)  
  end
end

def position_taken?(board, index)
 if board[index] != " " && board[index] != "" && board[index] != nil
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
      turn(board)
  
  end
end

def turn_count(board)
 
  counter = 0
  board.each do |game_piece|
    if (game_piece == "X") || (game_piece == "O")
     counter += 1 
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?    
    "X"
  elsif turn_count(board).odd?   
    "O"
  end
end

def full?(board)
  board.none? do |position|
    position == " "
  end
end
  
def draw?(board)
  if won?(board) != FALSE
    return false
  elsif full?(board) == TRUE
    return true
  end
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
  
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
   
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return "X"
    
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return "O"
    
    end
  end
  
    return nil
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
    
    
