# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left row
  [1,4,7],  # Middle row
  [2,5,8],  # Right row
  [0,4,8],  # Diagonal row
  [2,4,6]  # Diagonal row
]

# play method
def play(board)
  while !(over?(board))
    turn(board)
  end
  if !(draw?(board))
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

# code your #position_taken? method here!
def position_taken?(board, index)
  board[index] == !(" " || "" || nil) || board[index] == "X" || board[index] == "O"
end

# code your #valid_move? method here
def valid_move?(board, index)
  index.between?(0, 8) && !(position_taken?(board, index))
end

# turn method
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

# turn_count method
def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

# won? method
def won?(board)
  WIN_COMBINATIONS.detect do |move|
    board[move[0]] == board[move[1]] &&
    board[move[1]] == board[move[2]] &&
    position_taken?(board, move[0])
  end
end

# full? method
def full?(board)
  board.all?{|move| move == "X" || move =="O"}
end

# draw? method
def draw?(board)
  !(won?(board)) && full?(board)
end

# over? method
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

# winner method
def winner(board)
  if won?(board)
    board[won?(board).first]
  end
end
