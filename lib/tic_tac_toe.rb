## All of our game methods will be coded here.

## my number one problem with all these tests is 'declaring' the methods in the top of other methods when it is not needed 


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def input_to_index(input)
  index = input.to_i - 1
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(array, index)
  if array[index] == " " || array[index] == ""
    false
  elsif array[index] == nil
    false
  else
    true
  end
end

def valid_move?(array, index)
  if index.between?(0,8)
    if position_taken?(array, index) == false
    true
    end
  end
end

def turn_count(board)
  return board.count("X") + board.count("O")
end

def current_player(board)
  turn_count(board)
  if board.count(" ") == 9
    return "X"
  end
  if board.count(" ").even?
    return "O"
  else
    return "X"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  input_to_index(input)
  index = input_to_index(input)
  value = current_player(board)
    if valid_move?(board, index)
      move(board, index, value)
      display_board(board)
    else
    ##  puts "Invalid move, please select again"
    ##  display_board(board)
      turn(board)
    end
end

def turn_count(board)
  return board.count("X") + board.count("O")
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
      win_index_1 = combo[0]
      win_index_2 = combo[1]
      win_index_3 = combo[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return true
     elsif position_1 == "O"  && position_2 == "O" && position_3 == "O"
        return true
      end
  end
  return false
end

def full?(board)
  board.select do |space|
    if space == " "
      return false
    end
  end
return true
end

def draw?(board)
  if won?(board) == false && full?(board) == true
      puts "Cat's Game!"
      return true
    else
      return false
    end
    return false
end

def over?(board)
  draw?(board)
  won?(board)
  full?(board)
  if draw?(board) || full?(board) || won?(board)
    return true
  end
  return false
end

def winner(board)
    if won?(board)
      if board.count("X") > board.count("O")
        puts "Congratulations X!"
        return "X"
      else
        puts "Congratulations O!"
        return "O"
      end
    end
end

def play(board)
  while over?(board) == false
    turn(board)
  end
  if won?(board) == true
    winner(board)
  end
  if over?(board)
    if draw?(board)
      draw?(board)
    end
  end
end
