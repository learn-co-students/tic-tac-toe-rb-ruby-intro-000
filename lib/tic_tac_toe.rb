
WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def display_board (board)
 line1 = " #{board[0]} | #{board[1]} | #{board[2]} "
 line3 = " #{board[3]} | #{board[4]} | #{board[5]} "
 line5 = " #{board[6]} | #{board[7]} | #{board[8]} "
 line24 = "-----------"
 puts (line1)
 puts (line24)
 puts (line3)
 puts (line24)
 puts (line5)
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, position, player_token)
  board[position] = player_token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if position_taken?(board, index)
    return false
  elsif index.between?(0, 8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp
  index = input_to_index(user_input)
  if valid_move?(board, index)
    board[index] = current_player(board)
  else
  print "Please enter another number 1-9"
  user_input = gets.chomp
  end
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count +=1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board).to_i % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_combination.each do |location|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X")
        winner = "X"
        return win_combination
      elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
        winner = "O"
        return win_combination
      end
    end
  end
  return false
end

def full? (board)
  board.each do |element|
    unless element != "X" && element != "O"
      next
    else
      return false
      break
    end
  end
  return true
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) == true
    return true

  elsif won?(board) != false
    return true
  else
    return false
  end
end

def winner(board)
  unless won?(board) == false
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end
