WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def full?(board)
  board.all?{|token| token =="X" || token == "O"}
end

def draw?(board)
!won?(board) && full?(board)
end

def over?(board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end

def position_taken?(board, index)
  if board[index].nil? || board[index] == " "
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0,8) == true
  return true
  else
  return false
  end
end

def input_to_index(input)
  input.to_i - 1
end

def current_player(board)
  if turn_count(board) % 2 == 0
  value = "X"
  else
  value = "O"
  end
end

def move(board, index, value)
  board[index] = value
end

def turn(board)
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) != true
  puts "invalid"
  gets.strip  #asks for input again
  else
    move(board, index, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def won?(board)
  winner(board)
end

def winner(board)
  if board[0] == "X" && board[1] == "X" && board [2] == "X"
    return "X"
  elsif board[3] == "X" && board[4] == "X" && board [5] == "X"
    return "X"
  elsif board[6] == "X" && board[7] == "X" && board [8] == "X"
    return "X"
  elsif board[0] == "X" && board[3] == "X" && board [6] == "X"
    return "X"
  elsif board[1] == "X" && board[4] == "X" && board [7] == "X"
    return "X"
  elsif board[2] == "X" && board[5] == "X" && board [8] == "X"
    return "X"
  elsif board[0] == "X" && board[4] == "X" && board [8] == "X"
    return "X"
  elsif board[2] == "X" && board[4] == "X" && board [6] == "X"
    return "X"
  elsif board[0] == "O" && board[1] == "O" && board [2] == "O"
        return "O"
  elsif board[3] == "O" && board[4] == "O" && board [5] == "O"
        return "O"
  elsif board[6] == "O" && board[7] == "O" && board [8] == "O"
        return "O"
  elsif board[0] == "O" && board[3] == "O" && board [6] == "O"
        return "O"
  elsif board[1] == "O" && board[4] == "O" && board [7] == "O"
        return "O"
  elsif board[2] == "O" && board[5] == "O" && board [8] == "O"
        return "O"
  elsif board[0] == "O" && board[4] == "O" && board [8] == "O"
        return "O"
  elsif board[2] == "O" && board[4] == "O" && board [6] == "O"
        return "O"
  else
    return nil
  end
end


##
#def play(board)
#counter = 0
#  until counter == 9
#    turn(board)
#    counter += 1
#  end
#end
##
def play(board)
num_of_turns = 0
  until num_of_turns == 9 || over?(board) == true
    turn(board)
    num_of_turns += 1
  end
      if over?(board) == true && won?(board) == "X"
        puts "Congratulations X!"
      elsif
        over?(board) == true && won?(board) == "O"
        puts "Congratulations O!"
      elsif
        over?(board) == true && won?(board) != true
        puts "Cats Game!"
      else

    end
end
