# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #top
  [3,4,5], #Middle
  [6,7,8], #bottom
  [0,3,6], #left
  [1,4,7], #midddle column
  [2,5,8], #right
  [0,4,8], #left diagonal
  [2,4,6]  #right diagonal
]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(arr)
  puts " #{arr[0]} | #{arr[1]} | #{arr[2]} "
  puts "-----------"
  puts " #{arr[3]} | #{arr[4]} | #{arr[5]} "
  puts "-----------"
  puts " #{arr[6]} | #{arr[7]} | #{arr[8]} "
end

# code your input_to_index and move method here!
def input_to_index(num)
  input = num.to_i
  input -= 1
end

def move(board, position, char)
  board[position] = char
end

# code your #position_taken? method here!
def position_taken?(borad, index)
  if(borad[index] == " " || borad[index] == "" || borad[index] == nil)
    return false
  else
    return true
  end
end

def turn(board)
   puts "Please enter 1-9:"
   input = gets.strip
   index = input_to_index(input)
   if (valid_move?(board,index))
     move(board, index, current_player(board))
   else
     turn(board)
   end
   display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |ele|
    if (ele == "X" || ele == "O")
      count+= 1
    end
  end
  return count
end

def current_player(board)
  if (turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end
end

def won?(board)

  if(!board.include?("X") && !board.include?("O"))
    return nil
  end

  WIN_COMBINATIONS.each do |combination|
    index1 = combination[0]
    index2 = combination[1]
    index3 = combination[2]
    arr = [index1, index2, index3]
    if (board[index1] == "X" && board[index2] == "X" && board[index3] == "X")
      return arr
    end
    if (board[index1] == "O" && board[index2] == "O" && board[index3] == "O")
      return arr
    end
  end
  return false
end

def full?(board)
  if (board.include?(" "))
    return false
  else
    return true
  end
end

def draw?(board)
  if (full?(board) && !won?(board))
    return true
  end
  return false
end

def over?(board)
  if(draw?(board) || won?(board))
    return true
  else
    return false
  end
end

def winner(board)
    if(winner = won?(board))
      return board[winner[0]]
    else
      return nil
    end
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def play(board)
  while(!over?(board))
    turn(board)
  end
  if(winner(board))
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
