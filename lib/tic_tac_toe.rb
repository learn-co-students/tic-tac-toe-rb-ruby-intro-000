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

def move(board, index, playing)
  board[index] = playing
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    playing = current_player(board)
    move(board, index, playing)
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play (board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    winning_player = winner(board)
    puts "Congratulations #{winning_player}!"
  else
    puts "Cats Game!"
  end
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant

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

def won?(board)
  x_won = 0
  o_won = 0
  winning_combination = []
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
      winning_combination = combination
      x_won = 1
    elsif (board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O")
      winning_combination = combination
      o_won = 1
    end
  end

  if x_won == 1 && o_won == 0
    return winning_combination
  elsif x_won == 0 && o_won == 1
    return winning_combination
  else
    return false
  end
end

def full?(board)
  return board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != false
    return board[won?(board)[0]]
  else
    return nil
  end
end

def turn_count (board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  return count
end

def current_player (board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end
