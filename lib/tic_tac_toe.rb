board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

WIN_COMBINATIONS = [ 
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Left diagonal
  [2,4,6]  # Right diagonal
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(num)
  num = num.to_i - 1 
end


def move(board,index,value)
  board[index] = value
end 


def position_taken?(board,index)
  if board[index] == "" || board[index] == " " || board[index] == nil 
    return false
  else 
    return true
  end
end


def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board, index) == false
    return true 
  else 
    return false 
  end 
end 


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == false
    turn(board)
  else
    move(board,index,current_player(board))
    display_board(board)
  end
end 


def turn_count(board)
  turn = 0 
  board.each do |array|
    if array == "X" or array == "O"
      turn += 1 
    end 
  end
  return turn 
end 

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end 


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = win_combination[0]
    position_2 = win_combination[1]
    position_3 = win_combination[2]
  
    if position_taken?(board,position_1) && 
      board[position_1] == board[position_2] && 
      board[position_1] == board[position_3]   
      return win_combination
    end 
  end 
  return false
end 


def full?(board)
  board.all? {|x| x != " " }
end 


def draw?(board)
  !won?(board) && full?(board)
end


def over?(board)
  won?(board) || draw?(board) || full?(board)
end 


def winner(board)
  winning_array = won?(board)
  if won?(board) && board[winning_array[0]] == "X"
    return "X"
  elsif won?(board) && board[winning_array[0]] == "O"
      return "O"
  else 
    return nil 
  end 
end


def play(board)
  count = 0 
  until count == 9 
    if won?(board)
      puts "Congratulations #{winner(board)}!"
      break
    elsif over?(board)
      puts "Cat\'s Game!"
      break
    end 
  turn(board)  
  count += 1
  end
end 