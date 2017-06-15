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
  input.to_i - 1
end


def move(board, chosen_index, token)
  board[chosen_index] = token
end


def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    return true
  else
    return false
  end
end


def valid_move?(board, index)
  if (index >= 0 && index <= board.length - 1) && !position_taken?(board, index)
    return true
  else
    return false
  end
end


def turn(board)
    puts "Please enter 1-9:"
    index = gets.strip
    index = input_to_index(index)
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
  board.each do |position|
    if position == "X" || position == "O"
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
  WIN_COMBINATIONS.each do |combo|
    return combo if combo.all? { |index| board[index] == "X"  }
    return combo if combo.all? { |index| board[index] == "O"  }
  end
  false
end


def full?(board)
  board.all? do |element|
    element == "X" || element == "O"
  end
end


def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end


def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end


def winner(board)
  if !won?(board)
    return nil
  else
    return board[won?(board)[0]]
  end
end


def play(board)
  until won?(board) || full?(board)
    turn(board)
  end

  if won?(board)
    return "Congratulations #{winner(board)}"
  elsif draw?(board)
    return "Cats Game!"
  end
end
