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

def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (input)
  input.to_i - 1
end

def move (board, index, current_player)
  board[index] = current_player
  return board
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
      return false
    else board[index] == "X" || board[index] == "O"
      return true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
     return true
   else
     return false
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
  if turn_count(board).even?
    return "X"
  elsif turn_count(board).odd?
    return "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index (input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board (board)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
   index_1 = combo[0]
   index_2 = combo[1]
   index_3 = combo[2]

   position_1 = board[index_1]
   position_2 = board[index_2]
   position_3 = board[index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combo
    end
  end
  return false
end

def full?(board)
  board.all? do |index|
    index == "X" || index == "O"
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  index = []
  index = won?(board)
  if index == false
    return nil
  elsif
    board[index[0]] == "X"
      return "X"
  else
    return "O"
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
