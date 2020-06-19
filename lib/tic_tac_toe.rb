WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

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
  current_player = "X"
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  index.between?(0,8)
  if !position_taken?(board,index) && index.between?(0,8)
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board,index) == true
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board_array)
  counter = 0
  board_array.each do |index|
    if index == "X" || index == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board_array)
  counter = turn_count(board_array)
  if counter%2 == 0
    return "X"
  elsif counter%2 == 1
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each {|combination|
    index_0 = combination[0]
    index_1 = combination[1]
    index_2 = combination[2]
    position_1 = board[index_0]
    position_2 = board[index_1]
    position_3 = board[index_2]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combination
    end
  }
  return false
end

def full?(board)
  if board.all? {|index| index == "X" || index == "O"}
    true
  else
    false
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) || (won?(board) && full?(board)) || (won?(board) && !full?(board))
    return true
  else
    return false
  end
end

def winner(board)
  position = []
  position = won?(board)
  if position == false
    return nil
  elsif board[position[0]] == "X"
    return "X"
  elsif board[position[0]] == "O"
    return "O"
  end
end

def play (board)
  until over?(board)
     current_player(board)
     turn(board)
   end
   if won?(board)
     puts "Congratulations #{winner(board)}!"
   else
     puts "Cat's Game!"
   end
end
