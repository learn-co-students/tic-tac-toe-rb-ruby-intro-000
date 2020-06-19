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

def input_to_index(num)
  num.to_i - 1
end


def move(array, index, value)
  array[index] = value
end



def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    return true
  else
    return false
  end

end


def position_taken?(board, index)
  if(board[index] == " " || board[index] == "" || board[index] == nil )
    return false
  elsif (board[index] == "X" || board[index] == "O")
    return true
  end

end


def turn(board)
  puts "Current Player: #{current_player(board)} Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    value = current_player(board)
    move(board, index, value)
    display_board(board)
  else
    turn(board)
  end
end


def play(board)
 num_turn = 0
 until num_turn == 9
   num_turn += 1
   turn(board)
 end
end


def turn_count(board)
  counter = 0
  board.each do |token|
    if token == "X" || token == "O"
      counter += 1
    end
  end
  return counter
end


def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    index0 = win_combo[0]
    index1 = win_combo[1]
    index2 = win_combo[2]

    position1 = board[index0]
    position2 = board[index1]
    position3 = board[index2]

    if position1 == "X" && position2 == "X" && position3 == "X"
      return win_combo
    elsif position1 == "O" && position2 == "O" && position3 == "O"
      return win_combo
    end

  end
  return false

end


def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
  end
end


def draw?(board)
  if full?(board) && ! won?(board)
    return true
  else
    return false
  end
end


def over?(board)
  if draw?(board) || won?(board) || full?(board)
    return true
  else
    return false
  end
end


def winner(board)
  if won?(board)
    letter = won?(board)[0]

    if board[letter] == "X"
      return "X"
    else
      return "O"
    end

  end
  return nil
end


def play(board)
  until over?(board)
    turn(board)
  end

 if won?(board)
   puts "Congratulations #{winner(board)}!"
 elsif draw?(board)
   puts "Cat's Game!"
 end

end
