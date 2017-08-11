WIN_COMBINATIONS = [
  [0,1,2], #Top Row
  [3,4,5], # Middle Row
  [6,7,8], # Bottom Row
  [0,3,6], # Left Column
  [1,4,7], # Middle Column
  [2,5,8], # Right Column
  [0,4,8], # Left Diagonal
  [2,4,6] #Right Diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  position = input.to_i - 1
end

def move(board, position, char)
  board[position] = char
end

def position_taken?(board, index)
   board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    valid = true
  else
    valid = false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  number = gets.strip
  number = input_to_index(number)
  player = current_player(board)
  if valid_move?(board,number)
    move(board,number,player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = board.select{|spot| spot == "X" || spot == "O"}
  turns.size
end

def current_player(board)
  player = turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return combo
    end
  end
  return false
end

def full?(board)
  full = board.all? {|index| index == "X" || index == "O"}
end

def draw?(board)
  draw = full?(board) && !won?(board)
end

def over?(board)
  over = full?(board) || draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    winner = board[won?(board)[0]]
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
