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

def input_to_index(num)
  num = num.to_i
  num = num - 1
end

def move(board,index,value)
  board[index] = value
end

def position_taken?(board, index)
  if board[index] == " "
    return false
  else
    return true
  end
end

def valid_move?(board,index)
  if index.between?(0,8) && !position_taken?(board,index)
    return true
  else
    return false
  end
end

def turn_count(board)
  count = 0
  board.each do |value|
    if value == "X" || value == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board).even? == true
    return "X"
  else
    return "O"
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  outcome = valid_move?(board, index)
  if outcome == false
    input = gets.strip
  end
  if outcome == true
    move(board, index, current_player(board))
  end
  display_board(board)
end

def won?(board)
  if board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    return false
  end


  WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if (position_1 == "X"  && position_2 == "X" && position_3 == "X") ||
        (position_1 == "O"  && position_2 == "O" && position_3 == "O")


        return win_combination
      end
    end
    return false
end

def full?(board)
  board.each do |values|
    if values == " "
      return false
    end
  end
  return true
end

def draw?(board)
  if won?(board) == false
    return full?(board)
  end

end

def over?(board)
  if draw?(board) == true
    return true
  elsif won?(board) == false && full?(board) == false
    return false
  elsif won?(board) == false && full?(board) == true
    return false
  else
    return true
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X"  && position_2 == "X" && position_3 == "X")
      return "X"
    elsif (position_1 == "O"  && position_2 == "O" && position_3 == "O")
      return "O"
    end
  end
  return nil
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if winner(board) == "X" || winner(board) == "O"
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end

# play(board)
  # loop do
  #   turn(board)
  #   won?(board)
  #   draw?(board)
  #
  #   if over?(board) == true
  #     break
  #     # if winner(board) == "X"
  #     #   print "Congratulations X"
  #     # elsif winner(board) == "O"
  #     #   puts "Congratulations O"
  #     # end

  #   end
