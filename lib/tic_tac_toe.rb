WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(string)
  string.to_i - 1
end

def position_taken?(board, index)
  if (board[index] == "X" || board[index] == "O")
  true
  else
  false
  end
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    true
  else
    false
  end
end

def move(board, index, player)
  board[index] = player
end

def turn(board)
  valid = false
  while valid == false do
    player = current_player(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index, player)
      display_board(board)
      valid = true
    end
  end
end

def turn_count(board)
  count = 0
  board.each do |value|
    if value == "X" || value == "O"
      count +=1
    end
  end
  count
end


  def current_player(board)
    if turn_count(board) % 2 == 0
      player = "X"
    else
      player = "O"
    end
  end

def won?(board)
  winning_combination = WIN_COMBINATIONS.detect do |combo|
    (board[combo[0]] == "X" || board[combo[0]] == "O") && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
  end

  if winning_combination != nil
    winner = true
  else
    winner = false
  end

end

def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    draw = true
  else
    draw = false
  end
end

def over?(board)
  if won?(board) == true || draw?(board) == true
    over = true
  elsif turn_count(board) == 9
    over = true
  else
    over = false
  end
end

def winner(board)
  winning_combination = WIN_COMBINATIONS.detect do |combo|
    (board[combo[0]] == "X" || board[combo[0]] == "O") && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
  end
  if winning_combination != nil
    winner = board[winning_combination[0]]
  end
end

def play(board)
  while !over?(board)  do
    turn(board)
  end
  if won?(board)
    player = winner(board)
    puts "Congratulations #{player}!"
  else
    puts "Cat's Game!"
  end

end
