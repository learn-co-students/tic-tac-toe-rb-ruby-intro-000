#rspec spec/01_tic_tac_toe_spec.rb

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
  puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

def input_to_index(input)
   index = input.to_i - 1
   return index
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  board[index] != " "
end

def valid_move?(board, index)
  if index < 0 || index > 8
    return false
  elsif board[index] == " "
    return true
  else
    return false
  end
end

def turn_count(board)
  count = board.select{|i| i != " "}
  return count.length
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  token = current_player(board)

  if valid_move?(board, index)
    move(board, index, token)
    display_board(board)
  else
    puts "Please try again"
    turn(board)
  end
end

def won?(board)
  winner = []
  WIN_COMBINATIONS.each do |combo|
    value_1 = board[combo[0]]
    value_2 = board[combo[1]]
    value_3 = board[combo[2]]

    if value_3 == 'X' && value_2 == 'X' && value_1 == 'X'
      winner = combo
    elsif value_3 == 'O' && value_2 == 'O' && value_1 == 'O'
      winner = combo
    end
  end

  if winner.length == 3
    return winner
  else
    return false
  end
end

def full?(board)
  board.none?{|i| i == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if !won?(board)
    return nil
  elsif board[won?(board)[0]] == 'X'
    return 'X'
  elsif board[won?(board)[0]] == 'O'
    return 'O'
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cat's Game!"
  elsif winner(board) == 'X'
    puts "Congratulations X!"
  elsif winner(board) == 'O'
    puts "Congratulations O!"
  end
end
