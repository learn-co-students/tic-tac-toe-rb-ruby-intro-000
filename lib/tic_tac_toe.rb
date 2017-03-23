


# Define your WIN_COMBINATIONS constant
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
  winning_combination=nil
  winning_combination = WIN_COMBINATIONS.detect do |combination|
    board[combination[0]] != " " && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]
  end
end

def full?(board)
  !board.any?{|i| i==" "}
end

def draw?(board)
  true if !won?(board) && full?(board)
end

def over?(board)
  true if won?(board) || draw?(board) || full?(board)
end

def winner(board)
  winning_combo = won?(board)
  if winning_combo
    board[winning_combo[0]]
  else
    nil
  end
end

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(digit)
  index = digit.to_i - 1;
end

def move(board, index, player)
  board[index]="#{player}"
end

# code your #valid_move? method here
def valid_move?(board, index)
  position_on_board?(index) && !position_taken?(board,index)
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
# code your #position_taken? method here!
def position_taken?(board, index)
  if(board[index]=="X" || board[index]=="O")
    return true
  end
  return false
end

def position_on_board?(index)
  index.between?(0,8)
end

def turn(board)
  while true
    puts "Please enter 1-9:"
    input=gets.strip
    index=input_to_index(input);
    if(valid_move?(board,index))
      move(board,index,current_player(board))
      display_board(board)
      break
    end
  end
  index
end

def turn_count(board)
  turn=0
  board.each do |item|
    if(item=="O" || item=="X")
      turn+=1
    end
  end
  turn
end

def current_player(board)
  turn_count(board)%2==0?"X":"O"
end

# Define your play method below
def play(board)

  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
