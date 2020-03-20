
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [2,4,6],
    [0,4,8]
]
 
 # Define display_board that accepts a board and prints
# out the current state
def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(num)
  input = num.strip
  int =  input.to_i
  input = int - 1
  return input
end

def move(board,index,char)
  board[index] = char
  return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move?(board,index)
  if !position_taken?(board,index) && index >= 0 && index <=8
  return true
  else 
    return false
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
 if valid_move?(board,index)
 move(board,index,current_player(board))
display_board(board)
else 
  turn(board)
end
end

def turn_count(board)
    count = 0
    board.each do |value|
    if value =="X" || value == "O"
    count +=1
  end
 end
 return count
end

def current_player(board)
  next_turn = turn_count(board)
  if next_turn % 2 == 0 
    return 'X'
  else 
    return 'O'
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |combination|
    index_1 = combination[0]
    index_2 = combination[1]
    index_3 = combination[2]
    
    option_1 = board[index_1]
    option_2 = board[index_2]
    option_3 = board[index_3]

   if option_1 == option_2 && option_2 == option_3 && position_taken?(board,index_1)
     return combination
 end
 end 
  return false
end


def full?(board)
  board.all? { |value| value == 'X' || value == 'O'}
end

def draw?(board)
  cond_1 = full?(board) == true;
  cond_2 = won?(board) == false;
  if cond_2 && cond_1 
    return true
    elsif !cond_1 && !cond_2
    return false
   else cond_2 == true
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
  
  def winner(board)
    if won?(board)
    indexes = won?(board)
   return board[indexes[0]]
 else 
   return nil 
  end
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
def play(board)
puts "Welcome to Tic Tac Toe!"
display_board(board)
  while !over?(board)
  turn(board)
  end
  if won?(board)
  puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
  puts "Cat's Game!"
  end
  end
  
