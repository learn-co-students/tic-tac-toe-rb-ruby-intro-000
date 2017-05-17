def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[6,4,2]
]

def won?(board)
  WIN_COMBINATIONS.each do |comb|
      return comb if comb.all? { |idx| board[idx] == "X"  }
      return comb if comb.all? { |idx| board[idx] == "O"  }
  end

false
end

def full?(board)
  return true  if board.all?{|el| el == "X" || el == "O" }

end

def draw?(board)
  return false if won?(board).is_a?(Array)
  return true if full?(board)
  false

end

def over?(board)
  return true if draw?(board) || won?(board)
  false
end

def winner(board)
  return board[won?(board).first] if won?(board).is_a?(Array)
  nil
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def move(board , moves, char )
  board[moves] = char
  display_board(board)
end

def input_to_index(string)
  string.to_i - 1
end

def position_taken?(board , index)
  return true if board[index] == "X" || board[index] == "O"
  false
end
def valid_move?(board , index )
  return false unless index < 9 && index >= 0
  return true unless position_taken?(board,index)

  false
end

def turn(board)

  while true
      puts "Please enter 1-9:"
      move_pos = input_to_index(gets.chomp)
      break if valid_move?(board , move_pos)
  end
  move(board ,move_pos,current_player(board))
  display_board(board)
end

def current_player(board)
  return "O" if board.count("X") > board.count("O")
  "X"
end

def turn_count(board)
  board.count("X") + board.count("O")
end

def play(board)
    until over?(board)
      turn(board)
    end
    puts "Cats Game!" if draw?(board)
    puts "Congratulations #{winner(board)}!"
end
