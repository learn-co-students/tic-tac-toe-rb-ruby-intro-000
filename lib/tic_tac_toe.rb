# Define your WIN_COMBINATIONS constant
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
  
# Define your display_board here
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Define your input_to_index here
def input_to_index(user_input)
  user_input.to_i - 1
end

# Define your current_player here
def move(board, index, current_player)
  board[index] = current_player
end

# Define your position_taken? here
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your valid_move? here
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# Define your turn here
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

# Define your turn_count here
def turn_count(board)
  #returns the number of of turns that have been played
  counter = 0
  board.each do|element|
    if (element == "X") || (element == "O")
      counter += 1 
    end
  end
  return counter
end

# Define your current_player here
def current_player(board)
  (turn_count(board) % 2 == 0)? "X" : "O"
end

# Define your won? here
def won?(board)
  WIN_COMBINATIONS.each do |element|
    #element is each sub array in WIN_COMBINATIONS ex. [0,1,2]
    win_index_1 = element[0]
    win_index_2 = element[1]
    win_index_3 = element[2]


    #position_ gives you the X's and O's at the position in the board
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    position_array = [position_1,position_2,position_3]
    
    #tests to see if all of the positions in the array are O's
    choice_O = position_array.all? do|element|
      element == "O"
    end
    
    #tests to see if all of the positions in the array are X's
    choice_X = position_array.all? do|element|
      element == "X"
    end
    
      if ( (position_taken?(board,win_index_1)) && (position_taken?(board,win_index_2)) && (position_taken?(board,win_index_3)) )
        if (choice_X  || choice_O)
         return element
        end
      end
  end
    return false
  
end

#code the draw? method here
def full?(board)
  #return true if every element in the board contains something
  board.each do |element|
    if (element == " ") 
      return false
    end
  end
  return true
end

#code the draw? method here
def draw?(board)
   won?(board) == false && full?(board) == true
end

#code the over? method here
def over?(board)
  if ( won?(board) || draw?(board) || full?(board))
    return true
  else
    return false
  end
end

#code the winner method here
def winner(board)
  #return token x or o that won the game
  
  if ( won?(board) )
    position_array = []
    (won?(board)).each do |element|
      position_array << board[element]
    end
    choice_X = position_array.all? do|element|
        element == "X"
    end
    if (choice_X )
      return "X"
    else
      return "O"
    end
  end
end

#code the play method here
def play(board) 
  while over?(board) == false
    turn(board)
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cat's Game!"
  end
end

