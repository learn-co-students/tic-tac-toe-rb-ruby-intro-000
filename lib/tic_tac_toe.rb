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

# Define a method display_board that prints a 3x3 Tic Tac Toe Board
def display_board(board)
  row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  row2 = "-----------"
  row3 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row4 = "-----------"
  row5 = " #{board[6]} | #{board[7]} | #{board[8]} "
  puts row1
  puts row2
  puts row3
  puts row4
  puts row5
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(array, index, character)
  array[index] = character
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  character = current_player(board)
  if valid_move?(board, index)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
counter = 0
  board.each do |index|
    if index != " "
        counter += 1
    end
  end
    counter
end

def current_player(board)
  if turn_count(board) % 2 == 1
    return "O"
  else
    return "X"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
      win_combination
    end
  end
end

def full?(board)
  board.all? do |index|
    index == "X" || index =="O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if win_char = won?(board)
    board[win_char[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
