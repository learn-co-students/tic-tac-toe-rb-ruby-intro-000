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

def input_to_index(user_input)
  converted_input = "#{user_input}".to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  if board[index] ==" "
    false
  elsif board[index] ==""
    false
  elsif board[index] ==nil
    false
  else board [index]=="X" || board[index]=="O"
    true
  end
end

def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board, index) == false
    true
  else
    false
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if "#{turn}" == "X" || "#{turn}" == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? == true ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.any? do |win_combination|
    if board[win_combination[0]]=="X" && board[win_combination[1]]=="X" && board[win_combination[2]]=="X"
      return win_combination
    elsif board[win_combination[0]]=="O" && board[win_combination[1]]=="O" && board[win_combination[2]]=="O"
      return win_combination
    end
  end
end

def full?(board)
  board.all? {|index| index!=" "}
end

def draw?(board)
  won = won?(board)
  full = full?(board)
  if won==false && full==true
    return true
  elsif won==false && full==false
    return false
  else won!=false
    return false
  end
end

def over?(board)
  if won?(board)!=false || draw?(board)==true || full?(board)==true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)!=false
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)==true
    turn(board)
  end
  if won?(board)!=true && winner(board)=="X"
    puts "Congratulations X!"
  elsif won?(board)!=true && winner(board)=="O"
    puts "Congratulations O!"
  else draw?(board)==true
    puts "Cat's Game!"
  end
end
