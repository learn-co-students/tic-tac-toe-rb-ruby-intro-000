
# Helper Method
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

def move(board, index, current_player)
  board[index] = current_player
end

def valid_move?(board, pos)
  pos.between?(0,8) && !position_taken?(board, pos)
end

def position_taken?(board, pos)
  !(board[pos].nil? || board[pos] == " ")
end


def turn(board)
  #This is my method NOT using recursion
  puts "Please enter 1-9:"
  input = input_to_index(gets.chomp)
  if valid_move?(board, input) == false
    input = gets.chomp
  else
    move(board, input, current_player(board))
  end
  display_board(board)
end

def play(board)
  turn_num = 0
  while turn_num < 10 && !over?(board)
    turn(board)
    turn_num +=1
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

def turn_count(board)
  count = 0
  board.each do |pos|
    if pos != " "
      count +=1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  end
  return "O"
end


# END GAME SHIZZ


WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle rows
  [6,7,8], # bottom row
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8], # right column
  [0,4,8], # diagonal one
  [2,4,6] # diagonal two
]

def won?(board)
  WIN_COMBINATIONS.each do |win|
    if board[win[0]] == "X" && board[win[1]] == "X" && board[win[2]] == "X"
      return win
    elsif
      board[win[0]] == "O" && board[win[1]] == "O" && board[win[2]] == "O"
        return win
    end
  end
    return false
  end

def full?(board)
  return true unless board.include?(" ")
end

def draw?(board)
 if full?(board) && !won?(board)
   return true
  end
  return false
end

def over?(board)
  return true while (draw?(board) || won?(board))
  return false
end

def winner(board)
  if won?(board) && board[won?(board)[0]]  == "X"
    return "X"
  elsif won?(board) && board[won?(board)[0]] == "O"
    return "O"
  end
  return nil
end
