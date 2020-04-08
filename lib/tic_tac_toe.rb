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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
  if index.is_a? Integer
    index
  else
    -1
  end
end

def move(board, position, player)
  board[position] = player
end

def position_taken?(board, index)
  board[index] != " " && !board[index].nil?
end

def valid_move?(board, index)
  index.between?(0,8) && position_taken?(board, index) == false
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
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  turns = turn_count(board)
  if turns.even?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combination|
    board[combination[0]] == board[combination[1]] &&
    board[combination[1]] == board[combination[2]] &&
    position_taken?(board, combination[0])
  end
end

def full?(board)
  board.all? {|position| position == "X" || position == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if winning_combination = won?(board)
    board[winning_combination[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
