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
  puts '-----------'
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts '-----------'
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
  board
end

def position_taken?(board, index)
  board[index] == ' ' || board[index] == '' || board[index] == nil ? false : true
end

def valid_move?(board, index)
  if position_taken?(board, index)
    return false
  elsif index < 0 || index > 8
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  puts "Where would you like to go?"
  input = gets.strip
  index = input_to_index(input)

  until valid_move?(board, index)
    puts "Please enter 1-9:"
    puts "Where would you like to go?"
    input = gets.strip
    index = input_to_index(input)
  end
  player = current_player(board)
  move(board, index, player)
  display_board(board)
end

def turn_count(board)
  filled_positions = board.select {|pos| pos == "X" || pos == "O"}
  number_filled = filled_positions.length
end

def current_player(board)
  turn_count(board) % 2 == 0 ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    pos_1 = win_combo[0]
    pos_2 = win_combo[1]
    pos_3 = win_combo[2]

    position_1 = board[pos_1]
    position_2 = board[pos_2]
    position_3 = board[pos_3]

    if position_1 == 'X' && position_2 == 'X' && position_3 == 'X'
      return win_combo
    elsif position_1 == 'O' && position_2 == 'O' && position_3 == 'O'
      return win_combo
    end
  end
  false
end

def full?(board)
  board.all? {|position| position == "X" || position =="O"}
end

def draw?(board)
  won?(board) || !full?(board) ? false : true
end

def over?(board)
  won?(board) || full?(board) || draw?(board) ? true : false
end

def winner(board)
  if won?(board)
    win_combo = won?(board)
    position = win_combo[0]
    board[position]
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
