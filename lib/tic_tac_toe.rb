

# Define win combinations
WIN_COMBINATIONS = [
  [0,1,2], # Top horizontal
  [3,4,5], # Middle horizontal
  [6,7,8], # Bottom horizontal
  [0,3,6], # Left vertical
  [1,4,7], # Middle vertical
  [2,5,8], # Right vertical
  [0,4,8], # \ diagonal
  [2,4,6] # / diagonal
]

# Define the board display
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "] 

def display_board(board)
  line = lambda { |x,y,z| " %s | %s | %s " % [x,y,z] }
  dashes = "-"*11
  
  puts line[ board[0], board[1], board[2] ]
  puts dashes
  puts line[ board[3], board[4], board[5] ]
  puts dashes
  puts line[ board[6], board[7], board[8] ] 
end

# Convert user input to valid board index
def input_to_index(d)
  digit = d.to_i
  digit -= 1
  return digit
end

# Allows the player to make a move
def move(board, index, char)
  board[index] = char
end

# Checks to see if the given board position is available
def position_taken?(board, index)
  (board[index] == " ") || (board[index] == "") || (board[index] == nil) ? false : true
end

# Checks to see if the move submitted by the user is valid
def valid_move?(board,index)
  if index.between?(0,8)
    if !position_taken?(board, index)
      true
    else
      false
    end
  end
end

# Allows the user to take a turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  go = input_to_index(input)
  if (valid_move?(board, go))
    move(board, go, 'X')
    display_board(board)
  else
    turn(board)
  end
end

# Gets the number of turns played
def turn_count(board)
  turns = board.count { |i| i == 'X' || i == 'O' }
  turns
end

# Determines whose turn it is to go
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

# Determines if the board is full
def full?(board)
  if board.count { |x| x == "X" || x == "O" } == 9 
    true
  else
    false
  end
end

# Checks to see if there's a winning combination
def won?(board)
  win_combo = nil

  count_letter = lambda do |arr, letter| 
    true if arr.count(letter) === 3
  end

  if board.count { |x| x == " "} == 9
    false

  else

    WIN_COMBINATIONS.each do |combo|
      positions = [ board[combo[0]], board[combo[1]], board[combo[2]] ]
      if count_letter[positions, "O"] 
        win_combo = combo
      elsif count_letter[positions, "X"] 
        win_combo = combo
      elsif full?(board)
        false
      else
        false
      end
    end

  end
  return win_combo
end

# Checks to see if there's a draw
def draw?(board)
  if !won?(board) && full?(board)
    true
  elsif !won?(board) && !full?(board)
    false
  elsif won?(board)
    false
  end
end

# Determines if the game is over
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

# Determines which player has won
def winner(board)
  winner = nil
  pos = won?(board) ? won?(board) : 9 # used an int to avoid undefined method `[]' for nil:NilClass
  player = board.values_at(pos[0], pos[1], pos[2])

  count_letter = lambda do |arr, letter| 
    true if arr.count(letter) === 3
  end

  if count_letter[player, "X"]
    winner = "X"
  elsif count_letter[player, "O"]
    winner = "O"
  end 
    
  return winner
end
