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
  line = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts line
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts line
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, i, player)
  board[i] = player
end

def position_taken?(board, location)
  board[location] != " "
end

def valid_move?(board, location)
  !position_taken?(board, location) && location < 9 && location >= 0
end

def turn(board)
  puts "Please enter 1-9:"
  ui = gets.strip
  index = input_to_index(ui)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0

  board.each do |ele|
    if ele == "X" || ele == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turns = turn_count(board)

  if turns == 0 || turns.even?
    player = "X"
  else
    player = "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if win_combination.all?{|i| board[i] == "X"}
      return win_combination
    elsif win_combination.all?{|i| board[i] == "O"}
      return win_combination
    else
      false
    end
  end
  if board.all?{|ele| ele == " " || ele == ""}
    false
  end
end

def full?(board)
  board.all?{|ele| ele == "X" || ele == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  win_combination = won?(board)

  if draw?(board)
    nil
  elsif !win_combination
    nil
  elsif win_combination.all?{|i| board[i] == "X"}
    winner = "X"
  elsif win_combination.all?{|i| board[i] == "O"}
    winner = "O"
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
