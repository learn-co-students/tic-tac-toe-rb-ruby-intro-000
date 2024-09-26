# comments used since functions are not modular: imported
# I wasn't sure if I could place functions in difference files
# and have test pass
# I'm having fun at the end i.e batman_and_robin

# Winning combinations
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]
# display board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
# convert input to int and index
def input_to_index(move)
  return move.to_i - 1
end
#--------------------------------------------
# position_taken
def position_taken? (board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  end
  return true
end
# validate placement
def valid_move? (board, index)
  if index < 0 || index > 8
    return false
  end
taken = position_taken?(board, index)
return !taken
end
#----------------------------------------------
# player move
def move(board, index, player)
  board[index] = player
  return board
end
#-----------------------------------------------
# turn count
def turn_count(board)
  count = 0
  board.each do |el|
    if el != " "
      count += 1
    end
  end
  return count
end
# current player
def current_player(board)
next_turn = turn_count(board)

  if next_turn == 0 || next_turn % 2 == 0
    return "X"
  end
  return "O"
end
#-----------------------------------------------
# turn loop
def turn(board)
  check = false
  until check == true
    puts "Please enter 1-9:"
    input =  gets.strip.to_i
    if input > 0 && input < 10
      check = true
    end
  end
  index = input_to_index(input)
  is_valid = valid_move?(board, index)
  player_turn = current_player(board)
  if(is_valid)
    new_board = move(board, index,player_turn)
    puts display_board(new_board)
    return new_board
  else
    turn(board)
  end
end
#-------------------------------------------

# won check
def won?(board)
  for win_combo in WIN_COMBINATIONS
    win_idx_1= win_combo[0]
    win_idx_2= win_combo[1]
    win_idx_3= win_combo[2]


    position_1 = board[win_idx_1]
    position_2 = board[win_idx_2]
    position_3 = board[win_idx_3]

    if position_1 == "X" && position_2 =="X" && position_3 == "X"
      return [win_combo[0],win_combo[1],win_combo[2]]
    elsif  position_1 == "O" && position_2 =="O" && position_3 == "O"
   return [win_combo[0],win_combo[1],win_combo[2]]
    end
  end
  return false
end

# board full?
def full?(board)
  if board.any? {|el| el == " " }
    return false
  end
return true
end
# draw conditional check
def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
end
#-------------------------------------------
# game over?
def over?(board)
  if !!won?(board)
    return true
elsif draw?(board)
    return true
  end

  return false
end

# return winner not DRY: due to 'strict test'
def return_winner(board)
  for win_combo in WIN_COMBINATIONS
    win_idx_1= win_combo[0]
    win_idx_2= win_combo[1]
    win_idx_3= win_combo[2]
    position_1 = board[win_idx_1]
    position_2 = board[win_idx_2]
    position_3 = board[win_idx_3]
    if position_1 == "X" && position_2 =="X" && position_3 == "X"
      return "X"
    elsif  position_1 == "O" && position_2 =="O" && position_3 == "O"
   return "O"
    end
  end
end
# winner result
def winner(board)
  if !won?(board)
    return nil
  end
  return return_winner(board)
end
#-------------------------------------------
#play: this works but test wants stricter outputs
# def play(board)
#   how_wack_rappers_ruin_good_songs(board)
#   the_winner = nil
#   until won?(board)
#     the_winner = turn(board) # could test for nil first to make safe
#     if  draw?(board) || over?(board)
#       print "Cat's Game!"
#       return "Cat's Game!"
#     end
#   end
#   print "Congratulations #{winner(the_winner)}!"
#   return "Congratulations #{winner(the_winner)}!"
# end
#--------------------------------------------

#play v2
def play(board)
  how_wack_rappers_ruin_good_songs(board)
  until over?(board)
      turn(board)
     if won?(board)
       # return & print not sure which pass test
      #  puts "Congratulations #{winner(board)}!"
      #  return "Congratulations #{winner(board)}!"
      value = winner(board)
      puts Congratulations(value)
      return Congratulations(value)
     end
     if  draw?(board)
       print "Cat's Game!"
       return "Cat's Game!"
     end
   end
end
#--------------------------------------
def Congratulations(value)
return "Congratulations #{value}!"
end
#--------------------------------------
def how_wack_rappers_ruin_good_songs(board)
  if won?(board)
    batman_and_robin = winner(board)
    puts "Congratulations #{batman_and_robin}!"
    return "Congratulations #{batman_and_robin}!"
  end
  if draw?(board)
    puts "Cat's Game!"
    return "Cat's Game!"
  end
end
