# Define your WIN_COMBINATIONS constant
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

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Define input_to_index method that accepts user input
def input_to_index(user_input)
  return user_input.to_i - 1
end

# Define move method that takes three arguments (board array, index, value "default = X")
def move(array, index, value)
  array[index] = value
end

# Define #valid_move? method here
def valid_move?(board, index)
  if position_taken?(board, index) == true
    false
  elsif index <= 8 && index >= 0
    true
  end
end

# Define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
  if board[index] == " " || board[index] == ""
    false
  elsif board[index] == nil
    false
  elsif board[index] == "X" || board[index] == "O"
    true
  end
end

# Define turn method which accepts an array as an argument
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

# Define turn_count method which accepts a board array and returns how many moves have meen played
def turn_count(board)
  count = 0
  board.each do |value|
    if value == "X" || value == "O"
      count += 1
    end
  end

  return count
end

# define a method current_player that takes the board array as an argument and utilizes the method turn_count to determine who's turn it is
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

# won method : returns true if there is a winner; else if not
def won?(board)

    # loops through the 2D array WIN_COMBINATIONS
    WIN_COMBINATIONS.each do |combination|

      # flags
      x_win = 0
      o_win = 0

      combination.each do |index|

        # checks if player X wins
        if board[index] == "X"
          x_win += 1

          if x_win == 3
            return combination
          end
        else
          x_win = 0
        end

        # checks if player O wins
        if board[index] == "O"
          o_win += 1

          if o_win == 3
            return combination
          end
        else
          o_win = 0
        end

      end
    end

    # return false if there is no winner
    return false
end

# full method : accepts the array "board" and returns true if every element in the board contains a value "X" or "O"
def full?(board)
  board.each do |values|
    if values == " " || values == ""
      return false
    else
      true
    end
  end
end

# draw method : accepts the array "board" and returns true if the board has not been won but is full
def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

# over method : accepts the array "board" and returns true if board has been won, is a draw, or is full
def over?(board)
  if won?(board)
    return true
  elsif draw?(board)
    return true
  else
    false
  end
end

# won method" accepts board and returns the token "X" or "O" indicating the winner
def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

# Define play method : The play method is the main method of the tic tac toe application and is responsible for the game loop.
# A tic tac toe game must allow players to take turns, checking if the game is over after every turn, and at the conclusion of the game,
# whether because it was won or because it was a draw, reporting to the user the outcome of the game.
def play(board)
  until over?(board) == true
    turn(board)
  end
  if draw?(board) != true
    winner = winner(board)
    puts "Congratulations #{winner}!"
  else
    puts "Cat's Game!"
  end
end
