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

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

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
  count = 0
  i = 0
  while i < board.length
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
  elsif turn_count(board) % 2 == 1
    return "O"
  end
end

def won?(board)
  win = WIN_COMBINATIONS.each { |win|
    if board[win[0]] == "X" && board[win[1]] == "X" && board[win[2]] == "X"
      return win
    elsif board[win[0]] == "O" && board[win[1]] == "O" && board[win[2]] == "O"
      return win
    end
  }
  return false
end

def full?(board)
  if board.include?(" ")
    return false
  else
    return true
  end
end

def draw?(board)
  if won?(board) != false && full?(board) == true
    return false
  elsif won?(board) == false && full?(board) == true
    return true
  end
end

def over?(board)
  if won?(board) != false || draw?(board) == true || full?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != false
    return board[won?(board)[0]]
  end
end

def play(board)
  while over?(board) == false
    turn(board)
  end

  if draw?(board) == true
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
