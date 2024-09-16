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

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0,8)
end

def turn(board)
  puts "Where would you like to go (0-9)?"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board, index)
    puts "Invalid move."
    turn(board)
  else
    value = current_player(board)
    move(board, index, value)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if ((position == "X") || (position == "O"))
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end


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

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if combination.all? {|index| board[index] == "X"}
      return combination
    elsif combination.all? {|index| board[index] == "O"}
      return combination
    else
      false
    end
  end
  false
end

def full?(board)
  board.all? do |location|
    if ((location == "X") || (location == "O"))
      true
    else
      false
    end
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  (((full?(board)) || (won?(board))) || (draw?(board)))
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
