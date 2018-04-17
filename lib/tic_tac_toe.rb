



WIN_COMBINATIONS = [
[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[6,4,2],
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


# code your input_to_index and move method here!
def input_to_index(str)
str.to_i - 1
end


def move(display_board, index, value)
  display_board[index] = value
end


def position_taken?(board, index)
  if board[index] != " "
    return true
  else
    return false
 end
end

if board[index] == " " || board[index] == "" || board[index] == nil
  return true
elsif board[index] == "X" || board[index] == "O"
  return false
end
end


def valid_move?(board , index)
  if position_taken?(board , index)
      return true
  else
    return false
  end
end


def turn(board)
puts "Please enter 1-9:"
input = gets.strip
index = input_to_index(input)
valid_move?(board , index)
    if position_taken?(board, index)
        move(board,index,value="X")
        display_board(board)
    else
        puts "invalid"
        turn(board)
    end
end


def turn_count(board)
return board.count {|a| a == "X" || a == "O" }
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end



def won?(board)
  WIN_COMBINATIONS.each do |a|
      if board[a[0]] == "X" && board[a[1]] == "X" && board[a[2]] == "X"
        return a
      elsif board[a[0]] == "O" && board[a[1]] == "O" && board[a[2]] == "O"
      return a
    end
  end
  return false
end


def full?(board)
 board.include?(" ") ? false : true
end

def draw?(board)
  won?(board) ? false : true
end

def over?(board)
 if  won?(board).class == Array || full?(board) == true || draw?(board) == true
   return true
else
  return false
 end
end


def winner(board)
  WIN_COMBINATIONS.each do |a|
      if board[a[0]] == "X" && board[a[1]] == "X" && board[a[2]] == "X"
        return "X"
      elsif board[a[0]] == "O" && board[a[1]] == "O" && board[a[2]] == "O"
      return "O"
    end
  end
  return nil
end
