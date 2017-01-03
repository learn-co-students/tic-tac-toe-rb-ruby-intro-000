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
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  !(board[index] == nil || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0, board.length - 1) && !position_taken?(board, index)
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
  board.count{|e| e == "X" || e == "O" }
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
  winning_combo = false
  WIN_COMBINATIONS.each do |combo|
    if combo.all?{|e| position_taken?(board, e)}  #I feel this is not necessary, though it may be efficient in saving calculations. Whether to do #all #position_taken? or #any !#position_taken? is faster, (I suspect latter?) will be for when I have more time...not priority right now...
      all_x = combo.all?{|e| board[e] == "X" }
      all_o = combo.all?{|e| board[e] == "O" }
      if all_x || all_o
        winning_combo = combo
        break
      end
    end
  end
  winning_combo
end

def full?(board)
  board.all?{|space| space == "X" || space == "O" }
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
  else
    false
  end
end

def over?(board)
  if (won?board) || (full?board) || (draw?board)
    true
  else
    false
  end
end

def winner(board)
  if(won?board)
    board[won?(board)[0]]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    #puts "You won!!"
  else
    puts "Cats Game!"
  end
end
