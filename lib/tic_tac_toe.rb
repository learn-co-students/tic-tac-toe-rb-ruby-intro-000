WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], 
  [6,7,8],
  [0,3,6], # 1st column
  [1,4,7],
  [2,5,8],
  [0,4,8], # 1st diagonal
  [2,4,6]
  ]
  
board = [" "," "," "," "," "," "," "," "," "]
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

def move(board, index, character)
  board[index] = character 
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  character = current_player(board)
  if valid_move?(board, index)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0 
  board.each do |board_elem|
    if board_elem == "X" || board_elem == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
   board.each do |token|
    turn_count(board).even? ? (token = "X") : (token = "O")
    return token   
  end 
end

def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      win_index_0 = win_combination[0]
      win_index_1 = win_combination[1]
      win_index_2 = win_combination[2]
      
      position_1 = board[win_index_0]
      position_2 = board[win_index_1]
      position_3 = board[win_index_2]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
        elsif position_1 == "O" && position_2 == "O" && position_3  == "O"
        return win_combination
      end
    end
    return false 
  end
  
 def full?(board)
    board.all?{|elem| elem == "X" || elem == "O" }
  end
 
 def draw?(board)
   if full?(board) && !won?(board) 
     return true 
   elsif won?(board) 
   return false 
 end
 end
 
 def over?(board)
   if won?(board) || full?(board) || draw?(board)
     return true 
   else 
     false 
   end 
 end
 
 def winner(board)
   WIN_COMBINATIONS.each do |win_combination|
      win_index_0 = win_combination[0]
      win_index_1 = win_combination[1]
      win_index_2 = win_combination[2]
      
      position_1 = board[win_index_0]
      position_2 = board[win_index_1]
      position_3 = board[win_index_2]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return "X"
        elsif position_1 == "O" && position_2 == "O" && position_3  == "O"
        return "O"
      end
    end
    return nil  
 end

 def play(board)
    until over?(board)
        turn(board)
      end
        if won?(board) 
         puts "Congratulations #{winner(board)}!"
         elsif draw?(board)
         puts "Cat's Game!"
    end 
  end 