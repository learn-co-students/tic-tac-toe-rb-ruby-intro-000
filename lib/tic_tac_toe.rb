# Define your WIN_COMBINATIONS constant
#WIN_COMBINATIONS is a constant but it’s the parent array to our the children array.
#parent_array => WIN_COMBINATIONS = [ children_arrays ]
#children_arrays => [0,1,2],[3,4,5],[6,7,8]...[6,4,2]
WIN_COMBINATIONS = [
[0,1,2], # top_row
[3,4,5], # middle_row
[6,7,8], # bottom_row
[0,3,6], # left_column
[1,4,7], # center_column
[2,5,8], # right_column
[0,4,8], # left_diagonal
[6,4,2] # right_diagonal
]

#build structure of the board
puts board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']

#display_board method
def display_board
   puts row = ["   " "|" "   " "|" "   "]
   puts separator = "-----------"
   puts row
   puts separator
   puts row
 end

#board and position
def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#change player input in to integer
def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, marker)
 board[index] = marker
end

def position_taken? (board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if !position_taken?(board, index) && (index).between?(0,8)
    return true
  else
    return false
  end
end

#define current player
def current_player(board)
   turn_count(board) % 2 == 0 ? "X" : "O"
end

#turn
def turn(board)
  puts "Please enter 1-9:"
  #get the user input
  user_input = gets.strip
  #input to index
  index = input_to_index(user_input)
  #check for validation
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

#counts occupied positions
def turn_count(board)
   counter = 0
   board.each {|spaces|
      if spaces == "X" || spaces == "O"
         counter += 1
      end
   }
   counter
end

#winning combo
def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
      position_1 = board[win_index_1] # value of board at win_index_1
      position_2 = board[win_index_2] # value of board at win_index_2
      position_3 = board[win_index_3] # value of board at win_index_3
      if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
        return win_combination
      end
    end
    return false
end
#position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
#The above code means to return first element (position_1) & make sure the position is taken by X or O

def full?(board)
  if board.any? {|index| index == nil || index == " "}
    return false
  else
    return true
  end
end

def draw?(board)
   if !won?(board) && full?(board)
     return true
   elsif!full?(board) && !won?(board)
     return false
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

#determine the winner
def winner(board)
   if won?(board)
      return board[won?(board)[0]]
   end
end

#asks for players input on a turn of the game
def play(board)
   counter = 0
   until counter == 9
     turn(board)
     counter += 1
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
