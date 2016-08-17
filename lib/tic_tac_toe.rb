WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 4, 6],
  [2, 5, 8]
]

def display_board(board)
  row_length = 3
    for i in 0..board.length - 1
      print " " + board[i].to_s + " "
      remainder = (i + 1) % row_length
      if remainder > 0 and i < board.length - 1
        print "|"
      end

      if remainder == 0 and i < board.length - 1
        print "\n-----------\n"
      end
    end
    print "\n"
end

def input_to_index(index)
  index = index.to_i
  return index - 1
end

def move(board, position, character)
  board[position] = character
end

def position_taken?(board, index)
    if board.length <= index
      return true
    end

    element = board[index]
    case element
    when "X", "O"
      return true
    end

    return false
end

def valid_move?(board, index)
  if index < 0 or index >= board.length
    return false
  end
  return !position_taken?(board, index)
end

def get_index()
    puts "Please enter 1-9:"
    input = gets.strip
    return input_to_index(input)
end

def turn_count(board)
  taken = board.select do |el|
    el == 'X' || el == 'O'
  end

  return taken.length
end

def current_player(board)
  count_x = 0
  count_o = 0

  for i in 0...board.length
    case board[i]
    when "X"
      count_x += 1
    when "O"
      count_o += 1
    end
  end

  if count_x > count_o
    return "O"
  end
  if count_x < count_o
    return "X"
  end
  if count_x == count_o
    return "X"
  end
end

def turn(board)
  index = get_index()

  until valid_move?(board, index)
    index = get_index()
  end

  move(board, index, current_player(board))

  display_board(board)
end

def won?(board)
  if board.length == 0
    return false
  end

  winners = WIN_COMBINATIONS.select do |comb|
    comb.all? {|i| board[i] == "X"} or comb.all? {|i| board[i] == "O"}
  end

  if winners.length > 0
    return winners[0]
  end
  return false
end

def full?(board)
  return board.all? {|ch| ch == "X" or ch == "O"}
end

def draw?(board)
  if won?(board)
    return false
  else
    return full?(board)
  end
end

def over?(board)
  return won?(board) || draw?(board)
end

def winner(board)
  won = won?(board)
  if won
    return board[won?(board)[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end

  if draw?(board)
    puts "Cats Game!"
  end
end
