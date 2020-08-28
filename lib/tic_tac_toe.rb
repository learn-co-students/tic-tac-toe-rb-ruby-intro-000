# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, token)
  if !position_taken?(board, position)
    board[position] = token
  end
end

def valid_move?(board, index)
  if index <= board.length && index >= 0 && !(position_taken?(board, index))
    return true
  else return false
  end
end

WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8], # right column
  [0,4,8], # top left -> bot right diag
  [2,4,6]  # bot left -> top right diag
]

def matching_tokens?(set)
  if (set.all? {|token| token == "X"} || set.all? {|token| token == "O"})
    return true
  else return false
  end
end

def won?(board)
  win = false
  WIN_COMBINATIONS.each {|combination|
    win_position1 = combination[0]
    win_position2 = combination[1]
    win_position3 = combination[2]
    check = [board[win_position1], board[win_position2], board[win_position3]]
      if (matching_tokens?(check))
        win = combination
      end
  }
  return win
end

def full?(board)
  if (board.detect{|token| token == " "})
    return false
  else return true
  end
end

def draw?(board)
  if (!won?(board) && full?(board))
    return true
  else return false
  end
end

def over?(board)
  if (won?(board) || draw?(board)) #only used won? and draw? because draw? already checks for full?
    return true
  else return false
  end
end

def winner(board)
  if (over?(board) && !draw?(board))
    return board[won?(board)[0]]
  end
end

def turn(board)
  puts "Please input 1-9"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else turn(board)
  end
end

def turn_count(board)
  count = board.reject{|token| token == " "}
  return count.length
end

def current_player(board)
  if turn_count(board).even? # using even because if even amount of turns have passed i.e. 2, it is now turn 3, and thus X's turn
    "X"
  else
    "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
    end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else #ommitted using the "draw?" method because the only possible situation this else occurs is on a draw, so no need to check for it
    puts "Cat's Game!"
  end
end
