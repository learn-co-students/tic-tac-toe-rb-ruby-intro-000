WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8],
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

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0,8)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter number 1-9:"
  input = gets.strip
  index = input_to_index(input)
  current_player = current_player(board)
  if valid_move?(board, index)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space != " " && space != ""
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? == true ? "X" : "O"
end

def won?(board)
  combo = 0
  while combo < WIN_COMBINATIONS.length
    current_combo = WIN_COMBINATIONS[combo]

    win_x = current_combo.all? { |cell| board[cell] == "X" }
    win_o = current_combo.all? { |cell| board[cell] == "O" }

    if win_x == true || win_o == true
      return current_combo
    end
    combo += 1
  end
  false
end

def full?(board)
  board.none? do |cell|
    cell == "" || cell == " "
  end
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board) == false
    false
  else
    true
  end
end

def over?(board)
  if won?(board)
    true
  elsif full?(board)
    true
  elsif draw?(board)
    true
  else
    false
    end
end

def winner(board)
  if won?(board) == false
    nil
  else
  win_1 = won?(board)
    board[win_1[0]]
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end

  winner = winner(board)

  if won?(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
