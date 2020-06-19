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

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, position)
  board[position] != " " && board[position] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  count = 0
  board.each do |position|
    if (position == "X" || position == "O")
      count += 1
    end
  end
  count
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def current_player(board)
  if (turn_count(board) % 2 == 0)
    "X"
  else
    "O"
  end
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  combination = won?(board)
  if (combination)
    board[combination[0]]
  else
    nil
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  until valid_move?(board, index) do
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
  puts "turn"
  player = current_player(board)
  move(board, index, player)
  display_board(board)
end

def empty_board?(board)
  board.all? do |position|
    position != "X" && position != "O"
  end
end

def won?(board)
  result = false;
  WIN_COMBINATIONS.each do |combination|
    if combination.all? { |index| board[index] == "X"}
      result = combination
    elsif combination.all? { |index| board[index] == "O"}
      result = combination
    end
  end
  result;
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if (won?(board))
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
