#Displays current state of the game board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  puts "-----------"
end

#Nested array containing all possible win combinations.  The numbers are indices of the board array.
WIN_COMBINATIONS = [
  [0, 1, 2], #Top row
  [3, 4, 5], #Middle row
  [6, 7, 8], #Bottom row
  [0, 3, 6], #Left column
  [1, 4, 7], #Middle column
  [2, 5, 8], #Right column
  [0, 4, 8], #Diagonal 1
  [2, 4, 6], #Diagonal 2
]

#Converts input from player to valid array index (0-8)
def input_to_index(input)
  input.to_i - 1
end

#Checks to see if move is valid by passing the board and index through position_taken? and reconciling their selection with valid array indices
def valid_move?(board, index)
  if !position_taken?(board, index) && (index).between?(0,8)
    return true
  else
    return false
  end
end

#Helper method meant to check if the position on the board is currently taken, used by valid_move?
def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    return false
  else
    return true
  end
end

#Changes the board array to reflect a valid input provided by the player by updating an index within the array with the player token (character argument, initially defined here)
def move(board, index, character)
  board[index] = character
end

#What happens when the player takes a turn; if the player makes a valid input (is within board index 0-8 and the space is not taken by another X) then it will update the array with the player’s intended action.  If not, it will request another turn.
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each {|space|
    if space == "X" || space == "O"
      counter += 1
    end
  }
  counter
end

#Initiates 9 turns of play()
def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end
  if won?(board)
    winner(board) == "X" || winner(board) == "O"
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat\'s Game!"
  end
end

#Determines the turn count by iterating on the board array and adding to a counter for each instance of X or O
def turn_count(board)
  counter = 0
  board.each {|space|
    if space == "X" || space == "O"
      counter += 1
    end
  }
  counter
end

#Determines the current player (X or O) by determining if the current turn_count is divisible by 2.  Even numbered turns are naturally X while odd-numbered turns are naturally O, as X goes first.
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

#Iterates over WIN_COMBINATIONS using a new array to determine if there are 3 matching tokens in winning positions.
def won?(board)
  WIN_COMBINATIONS.each do |wincombo|
    if board[wincombo[0]] == "X" && board[wincombo[1]] == "X" && board[wincombo[2]] == "X"
      return wincombo
    elsif board[wincombo[0]] == "O" && board[wincombo[1]] == "O" && board[wincombo[2]] == "O"
      return wincombo
    end
  end
  return false
end

#Checks the board for any nil or “ “ in indices.  If there is, the board is not full and thus “false” is returned.
def full?(board)
  if board.any? {|index| index == nil || index == " "}
    return false
  else
    return true
  end
end

#If full?(board) is true and won?(board) is determined to be false, that means there must be a draw.  Otherwise, there is no draw.
#***Note that a board that isn’t full and a game that is not won must be specifically designated as false.
def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    false
  end
end

#Checks to see if anyone has won OR if the board is full.  In both cases, this method ends the game.
def over?(board)
  if won?(board) || full?(board)
    return true
  else
    return false
  end
end

#If the won? method is given a true outcome, then it returns index 0 after it is run through the won? method, which is necessarily the winning token (X or O).
def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end
