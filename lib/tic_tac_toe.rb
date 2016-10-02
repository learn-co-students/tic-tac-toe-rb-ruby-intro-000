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

def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, position, type)
  board[position] = type
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  elsif board[index] == "X" || board[index] == "O"
    true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && !(position_taken?(board, index))
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
    player = current_player(board)
    move(board, index, player)
  else
    turn(board)
  end

  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do | index |
    if index != " "
      count += 1
    end
  end
  count
end

def current_player(board)
  count = turn_count(board)
  if count.even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  return_array = []

  WIN_COMBINATIONS.each do | win_combo |
    if win_combo.all?{ | i | board[i] == "X"} || win_combo.all?{ | i | board[i] == "O"}
      return_array = win_combo
    end
  end

  if return_array == []
    false
  else
    return_array
  end
end

def full?(board)
  if board.all?{ | i | i != " "}
    true
  else
    false
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    true
  elsif won?(board) != false
    false
  else
    false
  end
end

def over?(board)
  if won?(board) != false || draw?(board) == true
    true
  else
    false
  end
end

def winner(board)
  if won?(board) != false
    return board[won?(board)[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if draw?(board) == true
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
