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

def position_taken?(board,index)
    !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board,index)
end

def turn(board)
  user_input = gets.strip
  index = input_to_index(user_input)

  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
 turncount=0

   board.each do |location|
     if location != " "
      turncount += 1
    end
  end
  turncount
end

def current_player(board)
 if turn_count(board).even?
   return "X"
 else
   return "O"
 end
end


def won?(board)
 WIN_COMBINATIONS.each do |win_comb|
   if board[win_comb[0]] =="X" && board[win_comb[1]] == "X" && board[win_comb[2]] == "X" ||  board[win_comb[0]] =="O" && board[win_comb[1]] == "O" && board[win_comb[2]] == "O"
      return win_comb
   end
 end
 false
end

def full?(board)
  board.all? do |index|
    index == "X" || index == "O"
  end
end

def draw?(board)
  if won?(board) || !full?(board)
      return false
    elsif full?(board) || !won?(board)
      return true
    else
      return false
   end
end

def over?(board)
   won?(board) || full?(board) || draw?(board)
end

def winner(board)
if won?(board)
 index = won?(board)
  if board[index[2]]  == "X"
      board[index[2]]
  elsif board[index[0]]  == "O"
     board[index[0]]
   end
  else nil
 end
end

def play(board)

  until over?(board)
    turn(board)
  end
if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif
   draw?(board)
  puts "Cats Game!"
end

end
