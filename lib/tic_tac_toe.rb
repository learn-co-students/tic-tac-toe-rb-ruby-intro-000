def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(entered_number)
  input = entered_number.to_i
  space = input - 1
end

def move(board_array, pos, char)
  board_array[pos] = char
end


def turn(board)
  puts "Please enter 1-9:"
  choice = gets.chomp
  pos = input_to_index(choice)
  if valid_move?(board, pos)
    move(board, pos, current_player(board))
    display_board(board)
  else
    display_board(board)
    turn(board)
  end
end


def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1

    end

  end
  return counter

end

def current_player(board)
  counter = turn_count(board)
  if counter % 2 == 0
    return "X"
  else
    return "O"

  end
end

# Helper Method
def valid_move?(board, choice)
  if choice >= 0 && choice <= 8 && !position_taken?(board, choice)
    return true
  else
    return false
  end
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS =
  [
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
  for win_combo in WIN_COMBINATIONS do

    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]


    if
      (board[win_index_1] == "X" && board[win_index_2] == "X" && board[win_index_3] == "X")
      return win_combo
    elsif
      (board[win_index_1] == "O" && board[win_index_2] == "O" && board[win_index_3] == "O")
      return win_combo

    end
  end
  return false
end

def full?(board)
  full = true
  for space in board do
    if space == "X" || space == "O"
      next
    else
      full = false
      return full
    end
  end
  return full
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
    win_place = won?(board)[0]
    return board[win_place]
  else
    nil
  end
end

def play(board)
  while !over?(board)
    turn(board)



  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end

end
