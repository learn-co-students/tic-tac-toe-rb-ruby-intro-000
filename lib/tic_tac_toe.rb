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
  input.to_i - 1
end

def move(board, space, token)
  board[space] = token
end

def position_taken?(board, space)
  space.between?(0, board.length) && (board[space] == "X" || board[space] == "O")
end

def valid_move?(board, space)
  space.between?(0, board.length) && !position_taken?(board, space)
end

def turn_count(board)
  count = 0
  board.each do |space|
    space == "X" || space == "O" ? count += 1 : count += 0
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  end
  return "O"
end

def turn(board)
  puts "Give a move: 1-9"
  index = input_to_index gets.strip
  if !valid_move?(board, index)
    puts "Invalid move"
    turn(board)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def spaces_equal?(board, spaces)
  if board.length == 0 || spaces.length == 0
    return false
  end
  val = board[spaces[0]]
  spaces.all? do |index|
    board[index] == val
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if (position_taken?(board, combo[0]) && spaces_equal?(board, combo))
      return combo
    end
  end
  return false
end

def full?(board)
  board.all? do |space|
    space == "X" or space=="O"
  end
end

def draw?(board)
  return full?(board) && !won?(board)
end

def over?(board)
  return full?(board) || won?(board) || draw?(board)
end

def winner(board)
  combo = won?(board)
  combo ? board[combo[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
