#The WIN_COMBINATIONS constant contains a nested array of various win combinations in Tic Tac Toe
WIN_COMBINATIONS = [
  [0,1,2], #Top Row Win
  [3,4,5], #Middle Row Win
  [6,7,8], #Bottom Row Win
  [0,3,6], #Left Column Win
  [1,4,7], #Middle Column Win
  [2,5,8], #Right Column Win
  [0,4,8], #Left Diagonal Win
  [2,4,6]  #Right Diagonal Win
]

#display_board prints the board based on the argument passed to it
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#input_to_index takes user's string input and converts it to interger and subtracts 1
def input_to_index(user_input)
  user_input.to_i - 1
end

#Plays the move based on user input
def move(board, index, current_player)
  board[index] = current_player
end

#position_taken lets the user know if the position is taken
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

#valid_move determins if the move is valid: not already taken and present on the game board
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

#The turn method asks user for input, converts it to an index, makes the move and displays
#board if the move is valid, or asks for a new position if invalid.
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

#turn_count takes an argument of the board array and returns the number of turns played
def turn_count(board)
  counter = 0
  board.each do |move|
    if move == "X" || move == "O"
      counter += 1
    end
  end
  return counter
end

#The #current_player method takes in an argument of the game board and uses the #turn_count method
#to determine whose turn it is
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  elsif turn_count(board) % 2 != 0
    return "O"
  end
end

#The #won method accepts a board as an argument and returns false if there is no win and returns
#the winning combination for a win
def won?(board)
  winning_combination =
    WIN_COMBINATIONS.select do |win_combination|
    #win_combination is a 3 element array of indexes that composes a win
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

      if board[win_index_1] == "X" && board[win_index_2] == "X" && board[win_index_3] == "X"
        return win_combination
      elsif board[win_index_1] == "O" && board[win_index_2] == "O" && board[win_index_3] == "O"
        return win_combination
      end
    end

  empty_board = board.all? do |board_index|
    board_index == nil || board_index == " "
  end

  if empty_board
    return false
  elsif !empty_board && winning_combination == []
    return false
  else
    return winning_combination
  end

end

#The #full method accepts a board and returns true if every slot on the board is filled
def full?(board)
  board.all? do |board_index|
    board_index == "X" || board_index == "O"
  end
end

#The #draw method accepts a board and returns true if board has not been won and is full,
#returns false if board is not full and not won, and false if the board is won.
def draw?(board)
  if !won?(board) && full?(board)
    true
  elsif !won?(board) && !full?(board)
    false
  elsif won?(board)
    false
  end
end

#The #over method accepts a board and returns true if board has been won, is a draw or is full.
def over?(board)
  won?(board) || full?(board) || draw?(board)
end

#The #winner method accepts a board and returns "X" or "O" as the winner given a winning board.
def winner(board)
  if won?(board) != false && over?(board) && !draw?(board)
    if board[won?(board)[0]] == "X" && board[won?(board)[1]] == "X" && board[won?(board)[2]] == "X"
      return "X"
    elsif board[won?(board)[0]] == "O" && board[won?(board)[1]] == "O" && board[won?(board)[2]] == "O"
      return "O"
    end
  end
end

#The #play method is invoked to play the game
def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
