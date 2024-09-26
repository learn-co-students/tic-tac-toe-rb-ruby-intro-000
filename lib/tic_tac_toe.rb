# define a constant, a nested array, with arrays of the index values for winning combinations
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

# method to print the current board representation
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# method to convert the user's input to the proper index for the board array
def input_to_index(input)
  input.to_i() - 1
end

# method to update the board, given a user's move
def move(board, index, character)
  board[index] = character
  display_board(board)
end

# helper method to determine whether a position has already been taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


# method to determine whether a player's move is valid
def valid_move?(board, index)
  if index.between?(0, 8) == false || position_taken?(board, index) == true
    return false
  else
    return true
  end
end  

# method to run a single turn of Tic Tac Toe
def turn(board)
  puts "Please enter 1-9:" #get user input
  input = gets.strip #store the user input
  index = input_to_index(input) #convert the user input to an index and store it
  if valid_move?(board, index) == true
    current = current_player(board)
    move(board, index, current)
  else
    turn(board)
  end
end

# method to return the number of turns that have been played
def turn_count(board)
  total_turns = 0;
  board.each do |piece|
    if piece == "X" || piece == "O"
      total_turns += 1
    end
  end
  return total_turns
end

#method returns the "X" or "O" to indicate which player's turn it is -- with a ternary operator
def current_player(board)
  turn_count(board).even? ? (return "X") : (return "O")
end

# method to determine whether there is a winning combination present
# returns the combination of indices if so
# returns false if not
def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    check = [board[win_combo[0]], board[win_combo[1]], board[win_combo[2]]]
    if check[0] == "X" && check[1] == "X" && check[2] == "X"
      return win_combo
    elsif check[0] == "O" && check[1] == "O" && check[2] == "O"
      return win_combo
    end
  end
  return false
end
  
#method returning whether the entire board is full
#AKA, if the none of the elements in the board array are " ", return true
def full?(board)
  board.none? {|char| char == " "}
end

#method returning whether the game is a draw
#returns true if the board is full and there is no winner
#returns false otherwise
def draw?(board)
  return full?(board) && won?(board) == false
end

#method returning whether the game is over
#returns true if there is a winner, there was a draw, or the board is full
def over?(board)
  return !won?(board) == false || draw?(board) || full?(board)
end

#method returning the winning player's character, given a winning game
#returns nil if passed a board with no winner
def winner(board)
  if won?(board) == false
    return nil
  else
    winning_combo_arr = won?(board)
    winning_char = board[winning_combo_arr[0]]
    return winning_char
  end
end

# main method
def play(board)
  while over?(board) != true
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end