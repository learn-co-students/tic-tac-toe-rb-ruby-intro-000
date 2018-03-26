
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
  print " #{board[0]} | #{board[1]} | #{board[2]} \n"
  print "-----------\n"
  print " #{board[3]} | #{board[4]} | #{board[5]} \n"
  print "-----------\n"
  print " #{board[6]} | #{board[7]} | #{board[8]} \n"
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, symbol)
      board[index] = symbol
end

def valid_move?(board, index)
  if index.between?(0, 8)==true
    if position_taken?(board, index)==true
      return false
    else
      return true
    end
  else
    return false
  end
end

def position_taken?(board, index)
position = board[index]
  if position==" "
    return false
  elsif position==""
    return false
  elsif position==nil
    return false
  elsif position=="X"
    return true
  elsif position=="O"
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    symbol = current_player(board)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
count = 0
board.each do |symbol|
  if symbol=="O"
    count += 1
  elsif symbol=="X"
    count += 1
  end
end
return count
end

def current_player(board)
if turn_count(board).even?
  return "X"
else
  return "O"
end
end

def won?(board)
count = 0
  while count<8 do
    if board.all? {|empty| empty==" "}
       return false
    elsif position_taken?(board, WIN_COMBINATIONS[count][0])&&position_taken?(board, WIN_COMBINATIONS[count][1])&&position_taken?(board, WIN_COMBINATIONS[count][2])&&board[WIN_COMBINATIONS[count][0]]==board[WIN_COMBINATIONS[count][1]]&&board[WIN_COMBINATIONS[count][1]]==board[WIN_COMBINATIONS[count][2]]
       return WIN_COMBINATIONS[count]
       break
    end
     count+=1
  end
if full?(board)&&count==8
   return false
end
end

def full?(board)
  if board.any?{|empty| empty==" "}
    return false
  else
    return true
  end
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  else
    return false
  end
end

def over?(board)
if won?(board)
  return true
elsif full?(board)
  return true
else
  return false
end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  while over?(board)==false
    turn(board)
    if won?(board)
      break
    elsif draw?(board)
      break
    end
  end
  if won?(board)
    puts "Congratulations "+ winner(board) +"!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
