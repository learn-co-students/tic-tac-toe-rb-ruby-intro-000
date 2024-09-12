def position_taken?(board,index)
  board[index]=="X" || board[index]=="O"
end

def display_board(board)
  puts(" #{board[0]} | #{board[1]} | #{board[2]} ")
  puts("-----------")
  puts(" #{board[3]} | #{board[4]} | #{board[5]} ")
  puts("-----------")
  puts(" #{board[6]} | #{board[7]} | #{board[8]} ")
end

def valid_move?(board,index)
  if index.between?(0,8)
    not(board[index]=="X" || board[index]=="O")
  else
    false
  end
end

def move(board,index,token)
  board[index]=token
end

def input_to_index(input)
  input.to_i - 1
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space=="X" || space=="O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

WIN_COMBINATIONS=[
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
  WIN_COMBINATIONS.detect{|combo| (board[combo[0]]=="X" || board[combo[0]]=="O") && board[combo[0]]==board[combo[1]] && board[combo[1]]==board[combo[2]]}
end

def full?(board)
  not(board.any?{|position| position==" "})
end

def draw?(board)
  full?(board) && not(won?(board))
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if (won?(board))
    board[won?(board)[0]]
  else
    nil
  end
end

def play(board)
  until(over?(board)) do
    turn(board)
  end
  if winner(board)=="X"
    puts "Congratulations X!"
  end
  if winner(board)=="O"
    puts "Congratulations O!"
  end
  if draw?(board)
    puts "Cat's Game!"
  end
end