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

def input_to_index(spot)
  spot.to_i - 1
end

def move(board, spot, character)
  board[spot] = character
  return board
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  if index.between?(0,8)
    !position_taken?(board, index)
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  spot = input_to_index(input)
  if valid_move?(board,spot)
    move(board, spot, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
      turns += 1
    end
  end
  return turns
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
  WIN_COMBINATIONS.each do |combos|
    position_1 = board[combos[0]]
    position_2 = board[combos[1]]
    position_3 = board[combos[2]]
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return combos
    end
  end
  return false
end

def full?(board)
  board.none?{|i| i == " " or i == ""}
end

def draw?(board)
  if won?(board)
    return false
  end
  if full?(board)

    return true
  end
  return false
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  end
  return false
end

def winner(board)
  combo = won?(board)
  if !combo
    return nil
  else
    return board[combo[0]]
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  else
    winning_player = winner(board)
    puts "Congratulations #{winning_player}!"
  end
end
