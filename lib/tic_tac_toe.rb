# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[0,1,2], #Top_row
[3,4,5], #Middle_row
[6,7,8], #Bottom_row
[0,3,6], #Vert_left
[1,4,7], #Vert_middle
[2,5,8], #Vert_right
[0,4,8], #Diag_left
[2,4,6], #Diag_right
]

#display_board - INSERIR
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#input_to_index - INSERIR
def input_to_index(user_input)
converted_input =  user_input .to_i - 1
end

#move - INSERIR RETIRANDO O "X"
def move(board, converted_input, user_input)
  board[converted_input] = user_input
end

#position_taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

#valid_move - INSERIR
def valid_move?(board, index)
		if position_taken?(board, index) == false && index.between?(0,8) == true
		    true
	  elsif position_taken?(board, index) == true
		    false
	  elsif index.between?(0, 8) == false
		    false
	  end
end

#turn
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end

end

#turn_count
def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  counter
end

#current_player - INSERIR
def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

#won_Method
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
      return win_combination
    end
  end
  return false
end

#full?_method
def full?(board)
    board.all? { |i| i == "X" || i=="O" }
  end

#draw?_method
def draw?(board)
  full?(board) && !won?(board)
end

#over?_method
  def over?(board)
    if won?(board) || draw?(board) || full?(board)
      return true
    end
  end

  #winner_method
  def winner(board)
    if won?(board)
      return board[won?(board) [0]]
    end
  end

#play_method
  def play(board)
    until over?(board)
        turn(board)
     end
    if won?(board)
        winner(board) == "X" || winner(board) == "O"
        puts "Congratulations #{winner(board)}!"
     elsif draw?(board)
        puts "Cat's Game!"
     end
  end
