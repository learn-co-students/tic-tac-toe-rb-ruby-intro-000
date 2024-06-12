# Winning Combonations
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

# Displays the current board to the user
def display_board(board)
  row = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} " + "\n" + row + "\n" +
       " #{board[3]} | #{board[4]} | #{board[5]} " + "\n" + row + "\n" +
       " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Coverts users input to an index
def input_to_index(user_input)
  return (user_input.to_i - 1)
end

# Adjusts board to players move
def move(board, index, player)
  board[index] = player
end

# Checks to see if user_input is taken on the board
def position_taken?(board, position)
  if board[position] == "" || board[position] == " "
    return false
  end
  return true
end

# Checks to see if the players move is valid
def valid_move?(board, index)
  if index > 8 || index < 0
    return false
  end
  if position_taken?(board, index)
    return false
  end
  return true
end

# Counts the number of turns taken
def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  return counter
end

# Returns the current player
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  end
  return "O"
end

# Makes the valid moves
def turn(board)
  puts "Please enter a number 1-9: "
  user_input = gets.chomp
  user_input = input_to_index(user_input)
  current = current_player(board)
  if valid_move?(board, user_input)
    move(board, user_input, current)
    display_board(board)
  else
    puts "Please enter a valid input 1-9: "
    turn(board)
  end
end

# Determines if the board is in a win state
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return combo
    end
  end
  return false
end

# Determines if the board is in a full state
def full?(board)
  if board.include?(" ") || board.include?("")
    return false
  end
  return true
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
  return false
end

# Determines if the game is over based on the boards state
def over?(board)
  if won?(board) || draw?(board)
    return true
  end
  return false
end

# Determines if there is a winner based on the boards state
def winner(board)
  win_combo = won?(board)
  if !win_combo
    return nil
  elsif (board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X")
    return "X"
  elsif (board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O")
    return "O"
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  else
    win = winner(board)
    puts "Congratulations #{win}!"
  end
end
