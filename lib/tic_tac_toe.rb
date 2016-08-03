# Displays 3x3 board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Converts user input 1-9 to index 0-8
def input_to_index(user_input)
  input_as_int = user_input.to_i
  index = input_as_int - 1
end

# Determines if the user input is valid for a move
def valid_move?(board, index)
  if index >= 0 && index <= 8
    if board[index] == " " || board[index] == "" || board[index] == nil
      return true
    else
      return false
    end
  else
    return false
  end
end

# Counts the number of turns
def turn_count(board)
  turn_count = 0
  board.each do |square|
    if square == "X" || square == "O"
      turn_count += 1
    end
  end
  return turn_count
end

# Determines whether it's X or O player based on turn count
def current_player(board)
  turn_count = turn_count(board).even? ? "X" : "O"
end

# Places an X or O on the board
def move(board, index, value)
  board[index] = value
end

# Turn loop
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index) == true
    value = current_player(board)
    move(board, index, value)
    display_board(board)
  else
    puts "invalid."
    turn(board)
  end
end

# Playing the Game
def play(board)
  while !(over?(board))
    turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  else
    puts "Cats Game!"
  end
end

# WIN_COMBINATIONS constant
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

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Winning Move?
def won?(board)
  WIN_COMBINATIONS.each do |combination|
    #pull values from board corresponding to winning combination
    position_1 = board[combination[0]]
    position_2 = board[combination[1]]
    position_3 = board[combination[2]]
    #check for a winner
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return combination
    end
    if position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combination
    end
  end
  return false
end

def full?(board)
  full = !(board.any? { |position| position == " " || nil })
  return full
end

def draw?(board)
  if !(won?(board))
    return full?(board)
  end
end

def over?(board)
  over = full?(board) || won?(board) || draw?(board)
  return over
end

def winner(board)
  win_combo = won?(board)
  if win_combo == false
    return nil
  else
    return board[win_combo[0]]
  end
end
