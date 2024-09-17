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

def input_to_index(input)
  input.to_i - 1
end

def move(board,index,value)
  board[index] = value
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == ""
    false
  elsif board[index] == nil
    false
  else true
 end
end

def valid_move?(board, index)
if index.between?(0,8) && !(position_taken?(board,index))
  true
 else false
 end
end

def turn(board)
  puts "Please enter 1-9:"
 input = gets.strip
 index = input_to_index(input)
 move(board,index,current_player(board))
 until val


 if !(valid_move(board,index))

   input = gets.strip
   index = input_to_index(input)
   move(board,index,current_player(board))

end

 else

 break

 move(board,index,current_player(board))
 display_board(board)
 if valid_move?(board,index)
 else
   puts "invalid move. please try again"
 break


end

  display_board(board)
end
 end

def turn_count(board)
  count = 0
  board.each do |i|
    if i == "X" || i == "O"
      count += 1
    end
end
return count
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else return "O"
end
end

def won?(board)
  WIN_COMBINATIONS.each do |winner_set|
    if position_taken?(board, winner_set[0]) &&
       board[winner_set[0]] == board[winner_set[1]] &&
       board[winner_set[0]] == board[winner_set[2]]
       return winner_set
    end
  end
  false
end

def full?(board)
  board.none? do |board_taken|
    if board_taken == " "
      true
    else
      false
    end
  end
end

def draw?(board)
  if !(won?(board)) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
  return board[won?(board)[0]]
else
  nil
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
