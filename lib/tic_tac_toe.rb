WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end

end

def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  if (turn_count(board) % 2) == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |win_state|
  if board[win_state[0]] == "X" && board[win_state[1]] == "X" && board[win_state[2]] == "X"
    win_state
  elsif board[win_state[0]] == "O" && board[win_state[1]] == "O" && board[win_state[2]] == "O"
    win_state
  else
    false
  end
end
end# Define y

def empty (spot)
  if spot == " " then true else false
  end
  end

def full?(board)

   if board.find {|p| empty(p) } == " " then
     false
   else
     true
   end

end

def draw? (board)
  if won?(board) then
    false
  elsif !full?(board)
    false
  elsif full?(board)
    true
  end
end

def over?(board)
  if won?(board) then
    true
  elsif draw?(board)
    true
  elsif full?(board)
    true
  else
    false
  end
end

def winner(board)
  token = nil
  winner_combo = WIN_COMBINATIONS.find do |win_state|
    if board[win_state[0]] == "X" && board[win_state[1]] == "X" && board[win_state[2]] == "X" then
      token = "X"
    elsif board[win_state[0]] == "O" && board[win_state[1]] == "O" && board[win_state[2]] == "O"
      token = "O"
    else
      nil
    end
    end
    if winner_combo then token else nil end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won? (board)
    puts "Congratulations #{winner(board)}!"
  elsif draw? (board)
    puts "Cat's Game!"
  end

end
