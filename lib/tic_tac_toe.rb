#player

def turn_count(board)
  turn = 0
  board.each do |space|
    if space == "X" || space == "O"
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  if turn_count(board)%2 == 0
    "X"
  else
    "O"
  end
end



# move
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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

def move(board, index, token)
  board[index] = token
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
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

#winning

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

def winning_combo?(board, win_combo, token)
  win_combo.all? do |spot|
    board[spot] == token
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    winning_combo?(board, win_combo, 'X') || winning_combo?(board, win_combo, 'O')
  end
end

def full?(board)
  board.all? do |spot|
    spot != " " && spot != ""
  end
end

def draw?(board)
  full?(board) && !(won?(board))
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  winning_combo = won?(board)
  if winning_combo
    return board[winning_combo[0]]
  else
    return nil
  end
end

# play

# Define your play method below
def play(board)
  round = 0
  while !over?(board)
    round += 1
    turn(board)
    #puts "#{won?(board)}"
  end
  if draw?(board)
    puts("Cat's Game!")
  else
    puts("Congratulations #{winner(board)}!")
  end
end
