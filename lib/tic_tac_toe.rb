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

def input_to_index(current)
  new_input=current.to_i
  return new_input -= 1
end
  def move(board,index,character)
   return board[index]=character
end
def position_taken?(board, index)
  board[index] != " "
end

def valid_move?(board,index)
  def   position_taken?(board,index)
    if  board[index] == "" || board[index] == " "|| board[index]==nil
       false
    else
       true
    end
  end

def board_valid?(num)
  if num.between?(0, 8)==true
     true
  else
     false
  end
end

if( position_taken?(board,index)) == false && (board_valid?(index) == true )
   true
else
  false
end
end


def turn_count(board)
   counter = 0
   board.each do |spaces|
      if spaces == "X" || spaces == "O"
         counter += 1
      end
   end
   counter
end




def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  current=current_player(board)

  if valid_move?(board, index)
    move(board, index,current)
    display_board(board)
  else
    puts "try it again"
    turn(board)
  end
  board
end

def current_player(board)
  turn = turn_count(board)
  if(turn %2 ==0)
    return "X"
  else
    return "O"
  end
end

def winner(board)
  index=[]
  index=won?(board)
  if index==false
    return nil
  else
    if board[index[0]]== "X"
      return "X"
    else
      return "O"
    end
  end
end


def won?(board)
  WIN_COMBINATIONS.each {|wc|
  win_index_1=wc[0]
  win_index_2=wc[1]
  win_index_3=wc[2]

p1=board[win_index_1]
p2=board[win_index_2]
p3=board[win_index_3]

if p1== "X"&&p2=="X"&&p3=="X"
  return wc
elsif p1== "O"&&p2=="O"&&p3=="O"
  return wc
end
}
return false
end

def full?(board)
  board.all? {|index| index == "X" || index=="O" }
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end



def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def play(board)
  until over?(board)==true||won?(board)==!false
    turn(board)
  end
  if won?(board)
    winner(board)=="X"|| winner(board)=="O"
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
  puts "Cat's Game!"
end
end
