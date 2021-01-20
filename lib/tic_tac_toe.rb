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

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  elsif board[index] == "X" || "O"
    true
  end
end

def input_to_index(input)
  index = (input.to_i) - 1
end

def move(board, index, token)
  board[index] = token
  return board
end

def valid_move?(board, index)
  if index.between?(0,8)
    if !position_taken?(board,index)
      true
    end
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each { |pos|
    if pos == 'X' || pos == 'O'
      counter += 1
    end
  }
  return counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.any?{|comb|
    if comb.all?{|pos| position_taken?(board, pos)}
      arr = [];
      comb.each{|pos| arr << board[pos]}
      if arr.uniq.size <=1
        return comb
      end
    end
  }
end

def full?(board)
  board.each_index.all?{|i| position_taken?(board,i)}
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    board_index = won?(board)[0]
    if board[board_index] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
