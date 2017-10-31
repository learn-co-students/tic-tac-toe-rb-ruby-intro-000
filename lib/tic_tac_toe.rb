WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [2,4,6], # Diognal from right
  [0,4,8], # Diognal from left
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8]  # Right column
]

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

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  # puts "board #{board}"
  # puts "index (position_taken) #{index}"
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  # puts "index (valid_move) #{index.to_i}"
  index.to_i.between?(0,8) && !position_taken?(board, index)

  # if index.between?(0,8)
  #  if !position_taken?(board, index)
  #    true
  #  end
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

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end


def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
  if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X" ||
      board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      return combo
    end
  end
  false
end

def full?(board)
  board.all? {|a| a.match(/[XO]/)}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
      board[won?(board).first]
  end
end
