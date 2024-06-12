# WIN_COMBINATIONS constant; 2-level array of all possible win combinations
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

# Display the board, whatever its contents
def  display_board(board = [" "," "," "," "," "," "," "," "," "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Turn the user's move input into an array index
def input_to_index(input)
  input.to_i - 1
end

# Allow a player to inpupt their move into the board
def move(board, index, token)
  board[index] = token
end

# Determine if a specific board position is taken; return "true" if so
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Determine if a user's move is valid; return "true" if so
def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0, 8)
    return true
  else
    return false
  end
end

# A complete turn
def turn(board)
  token = current_player(board)
  puts "Play #{token}, please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == false
    puts "Sorry, invalid move."
    turn(board)
  else
    move(board, index, token)
  end
  display_board(board)
end

# Count the number of turns that have been taken
def turn_count(board)
  turns = 0
  board.each do |position|
    if position == "X" || position == "O"
      turns += 1
    end
  end
  return turns
end

# Determine whose turn it is currently
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

# Return an array of the winning board indicies, or false if no winner
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
      return  win_combination
    end
  end
  return false
end

# Determine if the board is full
def full?(board)
  board.all? {|i| i == "X" || i == "O"}
end

# Determine if there is a draw
def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  else
    return false
  end
end

# Determine if the game is over
def over?(board)
  if draw?(board) == true
    return true
  elsif won?(board) != false
    return true
  elsif full?(board) == false
    return false
  end
end

# If the game is won, return the winner's token
def winner(board)
  if won?(board)
    win_combination = won?(board)
    token = board[win_combination[0]]
    return token
  end
end

# Start playing tic-tac-toe!
def play(board)
  until over?(board) ==  true
    turn(board)
  end
  if won?(board) != false
    token = winner(board)
    puts "Congratulations #{token}!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end
