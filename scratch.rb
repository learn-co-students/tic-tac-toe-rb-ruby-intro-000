def update_array_at_with(array, index, character = "X")
array[index] = "X"
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
      current_player(board)
      turn(board)
  end
end

def move(board, index, current_player)
  board[index] = current_player(board)
end

def play(board)
  counter = 0
    loop do
      counter = counter + 1
      turn(board)
      if over?(board) == true
        puts "Game over!"
      end
    if won?(board)
      puts "Congratulations"
    end
    if draw?(board)
      puts "We have a draw"
    end
end
end
