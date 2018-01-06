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

def input_to_index(number)
  number.to_i - 1
end

def move(board, index, sign)
  board[index] = sign
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  position_taken?(board, index) == false && index.between?(0,8)
end

def turn(board)
  puts "Please enter 1-9"
  number = gets.strip
  index = input_to_index(number)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else turn(board)
  end
  display_board(board)
end

def turn_count(board)
  board.count do |x| x == "X" || x == "O" end
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |com|
    board[com[0]] == board[com[1]] && 
    board[com[1]] == board[com[2]] &&
    position_taken?(board, com[0])
  end
end

def full?(board)
  board.all? do |x| x == "X" || x == "O" end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    winner = board[won?(board)[0]]
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