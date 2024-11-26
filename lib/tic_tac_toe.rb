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

def input_to_index(user_input)
  index = user_input.to_i - 1
  index
end

 def move(board, index, current_player)
  board[index.to_i] = current_player
  board
end

 def position_taken?(board, position)
  board[position] != " " && board[position] != "" &&  board[position] != nil
end

def valid_move?(board, position)
  position.to_i.between?(0,8) && !position_taken?(board, position.to_i)
end

def current_player(board)
 turn_count(board) % 2 == 0 ? "X" : "O"
end

 def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

 def turn_count(board)
  counter = 0
  board.each do |i|
    if i == "X" || i == "O"
      counter += 1
    end
  end
  counter
end



 def won?(board)

   WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

     position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

     if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
  end
end

 def full?(board)
  if board.detect {|i| i == " " || i == nil}
    false
  else
    true
  end
end

 def draw?(board)
  if !won?(board) && full?(board)
    true
  end
end

 def over?(board)
  if draw?(board) || won?(board)
    true

  end
end

 def winner(board)
  if win_combination = won?(board)
    board[win_combination.first]
  end
end

 def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
