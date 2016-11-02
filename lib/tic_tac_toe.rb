# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0, 1, 2],
                    [3, 4, 5],
                    [6, 7, 8],
                    [0, 3, 6],
                    [1, 4, 7],
                    [2, 5, 8],
                    [0, 4, 8],
                    [2, 4, 6]]

# ---HELPER METHODS---
def display_board(board)
  row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row3 = " #{board[6]} | #{board[7]} | #{board[8]} "
  line = "-----------"
  puts row1
  puts line
  puts row2
  puts line
  puts row3
end

def input_to_index(input)
  position = input.to_i - 1
end

def move(board, position, char)
  board[position] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  # for each win_combination in WIN_COMBINATIONS
  WIN_COMBINATIONS.each do |win_combination|
    # win_combination is a 3 element array of indexes that compose a win, [0, 1, 2]
    # grab each index from the win_combination that composes a win.
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
       (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination # return the win_combination indexes that won
    end
  end
  return false
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    true
  else
    false
  end
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
  # This method takes in an argument of the board array and returns the number of turns that have been played.
  turns_played = board.count{ |element| element == "X" || element == "O" }
  return turns_played
end

def current_player(board)
  # The current_player method should take in an argument of the game board and use the #turn_count method to determine if it is "X"'s turn or "O"'s.
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def full?(board)
  # should accept a board and return true if every element in the board contain either an "X" or an "O"
  if board.none? { |element| element == " " || element == "" || element == nil }
    return true
  else
    return false
  end
end

def draw?(board)
  # should accept a board and return true if the board has not been won and is full and false if the board is not won and the board is not full, and false if the board is won
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  # should accept a board and return true if the board has been won, is a draw, or is full
  return true if won?(board) != false || draw?(board) || full?(board)
end

def winner(board)
  # should accept a board and return the token, "X" or "O", that has won the game given a winning board
  board[won?(board)[0]] if won?(board)
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
