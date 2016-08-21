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

def play(board)
  while !over?
      turn(board)
  end

  if won?
    player_winner = "#{winner(board)}"
    puts "Congratulations...#{player_winner}!"
  elsif draw?
    puts "Cats Game!"
  end

end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# def valid_move?(board, index)
#   index.between?(0,8) && !position_taken?(board, index)
# end

def valid_move? (board, index)

  isTaken = position_taken?(board , index)

  if index.between?(0, 8)
    if isTaken
      return false
    else
      return true
    end
  else
    return false
  end
end

# def won?(board)
#   WIN_COMBINATIONS.detect do |combo|
#     board[combo[0]] == board[combo[1]] &&
#     board[combo[1]] == board[combo[2]] &&
#     position_taken?(board, combo[0])
#   end
# end

def won?(board)

  matches = []

  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
       (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination # return the win_combination indexes that won.
      #matches<<win_combination
    else
      matches = nil
    end
  end

  return matches

end


# def full?(board)
#   board.all?{|token| token == "X" || token == "O"}
# end

def full?(board)
  board.each do |element|
    if element == " "
      return false
    end
  end
  return true
end

def draw?(board)
    !won?(board) && full?(board)
end

# def over?(board)
#   won?(board) || draw?(board)
# end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def input_to_index (user_input)
  user_input = user_input.to_i
  user_input = user_input-1
end

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

# def position_taken?(board, index)
#   board[index]== "X" || board[index] == "O"
#   # Creates a stop on RSpec
#   # !(board[location].nil? || board[location] == "")
# end

def position_taken? (board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

# def turn_count(board)
#   board.count{|token| token == "X" || token == "O"}
# end

def turn_count(board)
    count = 0;
    board.each do |character|
      if character == "X" || character == "O"
        count+=1
      end
    end

    return count
end

def move(board, index, player)
  board[index] = player
end

# def winner(board)
#   if winning_combo = won?(board)
#     board[winning_combo.first]
#   end
# end

def winner(board)
  token = nil

  winner_player = won?(board)
  # print winner_player

  if winner_player
    if winner_player.class == Array
      position = winner_player[0]
      token = board[position]
    end
  end

end
