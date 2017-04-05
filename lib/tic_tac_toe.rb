def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0, 8)
    true
  else
    false
  end
end

def input_to_index(user_input)
  user_input.to_i - 1
end


board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
def move(board, index, value = "X")
  board[index] = value
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  if board[index] == " "
    false
  elsif board[index] == ""
    false
  elsif board[index] == nil
    false
  elsif board[index] == "X"
    true
  elsif board[index] == "O"
    true
  else
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = gets.strip.to_i - 1
  input_to_index(index)
  if valid_move?(board, index) == true && current_player(board) == "X"
    move(board, index, value = "X")
    display_board(board)
  elsif valid_move?(board, index) == true && current_player(board) == "O"
    move(board, index, value = "O")
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cats Game!"
  elsif over?(board) == false
    turn(board)
    play(board)
  elsif over?(board) == true
  end
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position == " "
      count += 0
    else
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

def won?(board)
  WIN_COMBINATIONS.each do |win_array|
    if board[win_array[0]] == "X" && board[win_array[1]] == "X" && board[win_array[2]] == "X"
      return win_array
    elsif board[win_array[0]] == "O" && board[win_array[1]] == "O" && board[win_array[2]] == "O"
      return win_array
    end
  end
  return false
end

def full?(board)
  if board.include?(" ")
    false
  else
    true
  end
end

def draw?(board)
  if full?(board) == false
    return false
  elsif won?(board)
    return false
  else
    return true
  end
end

def over?(board)
  if won?(board) == true || draw?(board) == true || full?(board) == true
    true
  else
    false
  end
end

def winner(board)
    WIN_COMBINATIONS.each do |win_array|
      if board[win_array[0]] == "X" && board[win_array[1]] == "X" && board[win_array[2]] == "X"
        return "X"
      elsif board[win_array[0]] == "O" && board[win_array[1]] == "O" && board[win_array[2]] == "O"
        return "O"
      end
    end
    if won?(board) == false
      nil
    end
  end
