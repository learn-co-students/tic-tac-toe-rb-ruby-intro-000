WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def input_to_index(input)
  index= input.to_i - 1
end
def move(board,index,character)
  board[index]=character
end
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
def valid_move?(board,index)
  if index.between?(0,8)
      if position_taken?(board,index)== true
      false
    else
      true
    end
  end
end
def turn(board)
  puts "Please enter 1-9:"
  input= gets.chomp
    index= input_to_index(input)
  if valid_move?(board,index)== true
    move(board,index,current_player(board))
    display_board(board)
  else
  turn(board)
  end
end
def turn_count(board)
  counter = 0
  board.each do |place|
    if place=="X" || place=="O"
      counter +=1
    end
  end
    turn_count = counter
end
def current_player(board)
  turn_count = turn_count(board)
  turn_count % 2 == 0 ? "X" : "O"
end
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if board[win_combination[0]]==board[win_combination[1]]&&board[win_combination[0]]==board[win_combination[2]]&&board[win_combination[0]]!=" "
      return win_combination
    end
  end
  false
end
def full?(board)
   all_full = board.all? do |position|
     position !=" "
   end
 end
 def draw?(board)
   full = full?(board)
   if won?(board)!= false || won?(board)== false && full== false
     return false
   end
   if won?(board)== false && full== true
     return true
   end
 end

 def over?(board)
     if won?(board)== true || full?(board)== true
       return true
    end
 end
 def winner(board)
   if won?(board)== false
     return nil
   else
     win_combination = won?(board)
       return board[win_combination[0]]
     end
   end
def play(board)
over = over?(board)
  until  over == true
    if won?(board) != false || draw?(board)== true
     break
    end
    turn(board)
     over = over?(board)
  end
  if won?(board)!= false
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)== true
    puts "Cats Game!"
  end
end
