WIN_COMBINATIONS =
[
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

def move(board,position,character = 'X')
  board[position] = character
end

def position_taken?(board,position)
  if board[position] == 'X' || board[position] == 'O'
    true
  else
    false
  end
end

def valid_move?(board,position)
  if position.between?(0,8) == true && position_taken?(board,position) == false
    true
  else
    false
  end
end

def turn(board)
  puts "Where do you want to move?"
  position = input_to_index(gets)
  while valid_move?(board,position) == false
    puts "Where do you want to move?"
    position = input_to_index(gets)
  end
  move(board,position)
end

def turn_count(board)
  counter = 0
  board.each do |move|
    if move == 'X' || move == 'O'
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return 'X'
  else
    return 'O'
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
      return win_combination
    elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
      return win_combination
    end
  end
  return false
end

def full?(board)
  board.none? do |positions|
    positions == " " || positions == "" || positions == nil
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  else
    return false
  end
end
