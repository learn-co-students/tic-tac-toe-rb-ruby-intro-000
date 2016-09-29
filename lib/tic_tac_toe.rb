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

# Helper Methods
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

# play a turn methods START
def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
# play a turn methods END

#decide curent player methods START
def turn_count(board)
  count = 0
  board.each do |entry|
    if (entry == "X" || entry == "O")
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end
#decide curent player methods END

# play a turn START
def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  index = input_to_index(position)
  if valid_move?(board, index)
    current_player = current_player(board)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end
# play a turn END


# game status methods
def won?(board)
  WIN_COMBINATIONS.each do |indices|
    result = indices.map { |i| board[i] }
    if result == ["X", "X", "X"] || result == ["O", "O", "O"]
      return indices
    end
  end
  false
end

def full?(board)
  !board.any? { |index| index == " " || index == "" || index == nil}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board) || full?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  else
    puts "Cats Game!"
  end
end
  # will change to until over?(board)
  # check who's turn it is
  # set the token appropriately
  # play a turn
  # if over?(board),
  # see what ended the game,
  # if won, announce winner,
  # otherwise announce a draw.
