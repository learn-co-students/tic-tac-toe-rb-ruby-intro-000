# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # m row
  [6,7,8], # b row
  [0,3,6], # l col
  [1,4,7], # m col
  [2,5,8], # r col
  [0,4,8], # l diag
  [2,4,6]  # r diag
]

# Helper Methods
def turn_count(board)
  turns = 0
  board.each do |space|
      if space == "X" || space == "O"
        turns += 1
      end
  end
  return turns
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    "X"
  else "O"
  end
end

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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    board[win_combination[0]] == board[win_combination[1]] &&
    board[win_combination[1]] == board[win_combination[2]] &&
    position_taken?(board,win_combination[0])
  end
end

def full?(board)
  board.all? do |char|
    char == "X" || char == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board) != nil
    win_combo = won?(board)
    return board[win_combo[0]]
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.to_s
  input = input.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    curr_player = current_player(board)
    move(board, index, curr_player)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  until over?(board)
  turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
