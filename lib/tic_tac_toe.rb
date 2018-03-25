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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  (input.to_i)-1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move? (board,index)
  if (!position_taken?(board,index)&&index.between?(0,8))
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index=gets.strip
  index=input_to_index(index)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
      turn(board)
  end
end

def turn_count (board)
  counter=0
  board.each do |square|
    if square=="X"||square=="O"
      counter+=1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1=win_combination[0]
    win_index_2=win_combination[1]
    win_index_3=win_combination[2]

    position_1=board[win_index_1]
    position_2=board[win_index_2]
    position_3=board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    #else
      #return false
    end
  end
  false
end

def full?(board)
  board.all?{|square| square=="X"||square=="O"}
end

def draw?(board)
  if !won?(board)&&full?(board)
    true
  else
    false
  #elsif !won(board)&&!full?(board)
    #false
  #elsif won?(board)
    #false
  end
end

def over?(board)
  if won?(board)||draw?(board)||full?(board)
    true
  end
end

def winner(board)
  if won?(board)!=false
    winning_combo=won?(board)
    winning_combo.each do |winning_letter_index|
      return board[winning_letter_index]
    end
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if winner(board)=="O"||winner(board)=="X"
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
