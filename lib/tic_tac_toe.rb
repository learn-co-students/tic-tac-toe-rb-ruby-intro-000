def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts " -----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts " -----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def position_taken? (board, index)
  if (board[index] == " " || board[index] == "")
    return false
  elsif (board[index] == "X" || board[index] == "O")
    return true
  else
    return false
  end
end
def valid_move?(board, index)
  if(index.between?(0,8))
    if(position_taken?(board, index) == false)
      return true
    else
      return false
    end
  else
    return false
  end
end

def input_to_index (number)
  number = number.to_i
  number = number - 1
end

def move(board, index, value)
  board[index] = value
end

def turn(board)
  puts "Please enter 1-9:"
  number = gets.strip
  index = input_to_index(number)
  if(valid_move?(board, index) == true)
    move(board,index,value="X")
  else
        puts "Please enter a valid number"
        turn(board)
  end
  display_board(board)
end

WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]

def won?(board)
    WIN_COMBINATIONS.detect do |combination|
      if(board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]] && position_taken?(board,combination[0]))
        return combination
      else
        false
      end
    end
  end


def full? (board)
  board.all? do |x|
    x == "X" || x == "O"
end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if(draw?(board) || won?(board))
    return true
  else
    false
  end
end

def winner(board)
  if(!won?(board))
    return nil
  elsif(board[won?(board)[0]] == "X")
    return "X"
  elsif (board[won?(board)[0]] == "O")
      return "O"
  end
end

def turn_count(board)
  count = 0
while count < 10
  board.each do |value|
    if(value =="X" || value == "O")
    count = count+1
  end
  end
  return count
end
end

def current_player(board)
  if (turn_count(board).odd?)
    return "O"
  else
    return "X"
  end
end
