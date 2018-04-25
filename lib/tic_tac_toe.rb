

WIN_COMBINATIONS =
[
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

  WIN_COMBINATIONS.each do |win_index|
      win_index_1 = win_index[0]
      win_index_2 = win_index[1]
      win_index_3 = win_index[2]

      board_position_1 = board[win_index_1]
      board_position_2 = board[win_index_2]
      board_position_3 = board[win_index_3]

      if board_position_1 =="X" && board_position_2 == "X" && board_position_3 =="X"
        return win_index
      elsif board_position_1 =="O" && board_position_2 == "O" && board_position_3 =="O"
        return win_index
      end
  end
  return false
end


def full?(board)
  board.none? do |position|
    position == nil || position == " "
  end
end

def draw?(board)
won = won?(board)
full = full?(board)

  if won == false && full == true
    return true
  elsif won == false && full == false
    return false
  elsif won == true
    return false
  end

end



def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
end

def winner(board)
  winner = won?(board)
  if winner != false
    return "#{board[winner[0]]}"
  end
  return nil
end

def turn_count(board)
counter = 0
  board.each do |numba|
    if numba == "X" || numba == "O"
      counter +=1
    end
  end
return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


def play(board)
  max_turns = 0

  until max_turns == 9
      draw = draw?(board)
      won = won?(board)
      over = over?(board)

      if draw
        puts "Cat's Game!"
        break
      elsif won
        puts "Congratulations #{board[won?(board)[0]]}!"
        break
      elsif over
        break
      end

      turn(board)
      max_turns += 1
  end

end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    player_token = current_player(board)
    move(board, index, player_token)
    display_board(board)

  else
    turn(board)
  end

end

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

def move(board, index, player_token)

  board[index] = player_token
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
