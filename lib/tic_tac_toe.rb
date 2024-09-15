WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

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
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
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

def turn_count(board)
  turn = 0
  board.each do |element|
    if element == 'X' || element == 'O'
      turn = turn + 1
    end
  end
  return turn
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return 'X'
  else
    return 'O'
  end
end

def won?(board)
  wincombo=[]
WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == 'X' && board[combo[1]] == 'X' && board[combo[2]] == 'X'
      return combo
    elsif board[combo[0]] == 'O' && board[combo[1]] == 'O' && board[combo[2]] == 'O'
      return combo
    end
  end
  return false
end

def full?(board)
  board.each do |element|
    if element == '' || element == ' '
      return false
    end
  end
  return true
end

def draw?(board)
  if full?(board) == false
    return false
  elsif won?(board) == false
    return true
  end
end

def over?(board)
  if full?(board) == true
    return true
  elsif won?(board) == false
    return false
  else
    return true
  end
end

def winner(board)
  if won?(board) == false
    return nil
  else
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board) == true
    if draw?(board)
      return "Cat\'s Game!"
    end
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat\'s Game!"
  end
end
