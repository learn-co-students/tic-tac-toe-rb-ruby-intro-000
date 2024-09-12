WIN_COMBINATIONS = [
    [0,1,2], # row wins
    [3,4,5],
    [6,7,8],
    [0,3,6], # column wins
    [1,4,7],
    [2,5,8],
    [0,4,8], # diagonal wins
    [2,4,6]
]
 
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
    index.between?(0, 8) && !position_taken?(board, index)
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

def turn_count(board)
  position_counter = 0
  board.each do |position| 
    if position == "X" || position == "O" 
      position_counter += 1
    end
  end
  return position_counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board) # returns winning combination
  WIN_COMBINATIONS.detect do |combo|
    combo.all? { |pos| board[pos] == "X"} || combo.all? { |pos| board[pos] == "O"}
  end
end

def full?(board)
  board.all? do |pos|
    pos == "X" || pos == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board) # All objects have true boolean value - except false, nil 
    board[won?(board).first]
  end
end

def play(board)
  until over?(board) 
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat's Game!" 
  end
end