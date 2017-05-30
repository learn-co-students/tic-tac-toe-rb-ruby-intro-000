
WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7],
[2, 5, 8], [0, 4, 8], [2, 4, 6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (user_input)
  user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if (index < 0 || index > 8)
    false
  elsif (position_taken?(board, index))
    false
  else
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if (valid_move?(board, index))
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "Invalid move. Please try again!"
    user_input = gets.strip
  end
end

def turn_count(board)
  counter = 0
  board.each do |turns|
    if (turns == "X" || turns == "O")
    counter += 1
    end
  end
  return counter
end

def current_player(board)
  counter = turn_count(board)
  if (counter.even? == true)
    player = "X"
  else
    player = "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_array|
  board[win_array[0]] == board[win_array[1]] && board[win_array[1]] == board[win_array[2]] && position_taken?(board, win_array[0])
  end
end

def full?(board)
  board.all?{|position| position == "X" || position == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if win_combination = won?(board)
  board[win_combination.first]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
