WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if !(position_taken?(board, index)) && index.between?(0,8)
    return true
  end
  return false
end

def turn(board)
  puts "Move? "
  input = gets.strip
  index = input_to_index(input)
  if (valid_move?(board, index))
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  return board.count{|turns| turns == "X" || turns == "O"}
end

def current_player(board)
  current = turn_count(board)
  if (current.even?)
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if ((position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O"))
      return win_combination
    end
  end
  return false
end

def full?(board)
  return !(board.include?(nil || " "))
end

def draw?(board)
  fullboard = full?(board)
  wonboard = won?(board)
  return (fullboard && !(wonboard))
end

def over?(board)
  fullboard = full?(board)
  wonboard = won?(board)
  drawboard = draw?(board)
  return (fullboard || wonboard || drawboard)
end

def winner(board)
  if (won?(board))
    wincomb = won?(board)
    return board[wincomb[0]]
  end
end

def play(board)
  until (over?(board))
    turn(board)
  end
  if (draw?(board))
    puts "Cats Game!"
  elsif (won?(board))
    winname = winner(board)
    puts "Congratulations #{winname}!"
  end
end
