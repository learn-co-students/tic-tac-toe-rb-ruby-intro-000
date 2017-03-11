def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def won?(board)
  WIN_COMBINATIONS.each do |win_array|
    win_array.each do |win_index|
      if board[win_array[0]] == board[win_array[1]] && board[win_array[1]] == board[win_array[2]] && position_taken?(board, win_array[1])
        return win_array
      end
    end
  end
  return false
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
return false
end

def full?(board)
  board.all? do |input|
    input == "X" || input == "O"
  end
end

def over?(board)
  if full?(board) && draw?(board) || won?(board)
    return true
  end
  return false
end

def winner(board)
  WIN_COMBINATIONS.each do |win_array|
    win_array.each do |win_index|
      if board[win_array[0]] == board[win_array[1]] && board[win_array[1]] == board[win_array[2]] && position_taken?(board, win_array[1])
        return board[win_array[0]]
      end
    end
  end
return nil
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i-1
end

def position_taken?(board, user_input)
  if board[user_input] == ""
    return false
  elsif board[user_input] == " "
    return false
  elsif board[user_input] == nil
    return false
  else board[user_input] == "X" || "O"
    return true
  end
end

def valid_move?(board, user_input)
  if position_taken?(board, user_input) == false && user_input.between?(0,8) == true
    true
  else
    false
  end
end

def move(board, user_input, current_player)
  board[user_input] = current_player
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
  board.each do |entry|
    if entry == "X" || entry == "O"
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end
