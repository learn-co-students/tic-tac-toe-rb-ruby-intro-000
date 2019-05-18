WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
]

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if (board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X") || (board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O")
      return win_combination
    end
  end
  WIN_COMBINATIONS.none? do |win_combination|
    (board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X") || (board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O")
    return false
  end
end

def full?(board)
  board.none? do |space|
    space == " " || space == "" || space == nil
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
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) == false
    return nil
  else
    win_combination = won?(board)
    if board[win_combination[0]] == "X"
      return "X"
    elsif board[win_combination[0]] == "O"
      return "O"
    end
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space != " " && space != "" && space != nil
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  number = turn_count(board)
  if number.odd?
    return "O"
  else
    return "X"
  end
end

def position_free?(board, index)
  board[index] == " " || board[index] == "" || board[index] == nil
end

def valid_move?(board, index)
  index >= 0 && index <= 8 && position_free?(board, index)
end

def move(board, index, value)
  board[index] = value
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  until valid_move?(board, index)
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
