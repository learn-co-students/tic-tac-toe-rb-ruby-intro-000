WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]

def won?(board)
  WIN_COMBINATIONS.each do |win|
      if board[win[0]] == "X" && board[win[1]] == "X" && board[win[2]] == "X"
        return win
      elsif board[win[0]] == "O" && board[win[1]] == "O" && board[win[2]] == "O"
        return win
      end
    end
    return nil
  end

def full?(board)
  i = 0
  while i < 9
    if board[i] != "X" && board[i] != "O"
      return false
    end
    i += 1
  end
  return true
end

def draw?(board)
  if won?(board) == nil && full?(board) == true
    return true
  end
  return false
end

def over?(board)
  if won?(board).class == Array || draw?(board) == true || full?(board) == true
    return true
  end
  return false
end

def winner(board)
  if draw?(board) == true || over?(board) == false
    return nil
  else
    number = won?(board)[0]
    return board[number]
end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
  if index < 0 || index > 8
    return false
  elsif position_taken?(board,index) == false
    return true
  else
    return false
  end
end


# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken? (board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
else
  return true
end
end

def input_to_index(number)
  index = number.to_i - 1
end

def move(array, index, value)
  array[index] = value
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  i = 0
  count = 0
  while i < 8
    if position_taken?(board,i) == true
      count += 1
    end
    i += 1
  end
  while valid_move?(board, index) == false
      input = gets.strip
      index = input_to_index(input)
      valid_move?(board,index)
    end
    if count % 2 == 0
      move(board,index,"X")
      display_board(board)
    else
      move(board,index,"O")
      display_board(board)
    end
end

def turn_count(board)
  i = 0
  count = 0
  while i < 9
    if board[i] == "X" || board[i] == "O"
      count += 1
    end
    i += 1
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def play(board)
  while over?(board) == false
    turn(board)
  end
end
