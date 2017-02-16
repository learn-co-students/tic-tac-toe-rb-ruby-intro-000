WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]
require 'pry'
# Helper Methods
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

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  #binding.pry
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count { |el| el == "X" || el == "O"}
end

def current_player(board)
  turn_count(board)%2==0? "X" : "O"
end

def won?(board)
    WIN_COMBINATIONS.each do |sub_arr|
      arr = [board[sub_arr[0]],board[sub_arr[1]],board[sub_arr[2]]]
      if arr == ["X","X","X"] || arr == ["O","O","O"]
        return sub_arr
      end
    end
    return false
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
def is_empty(board)
  return board.all? {|b| b == " " }
end
def is_draw(board)
  return (board == ["X", "O", "X", "O", "X", "X", "O", "X", "O"] || board == ["O", "X", "O", "X", "O", "O", "X", "O", "X"])
end


def draw?(board)
  if is_draw(board) && full?(board)
    return true
  elsif won?(board)
    return false
  elsif is_game_in_progress(board)
    return false
  end
end

def over?(board)
  if ( draw?(board) || won?(board) )
    return true
  elsif is_game_in_progress(board)
    return false
  else
    return false
  end
end

def winner(board)
    if won?(board)
      board[won?(board)[0]]
    end
end

def is_game_in_progress(board)
  if (board.any?{ |i| i == " " || i == "  " })
    return true
  else
    return false
  end
end

def full?(board)
  if is_draw(board)
    return true
  elsif is_game_in_progress(board)   #If atleast one spot is " "
    return false
  end
end

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    w = winner(board)
    puts "Congratulations #{w}!"
  elsif(draw?(board))
    puts "draw game"
    puts "Cats Game!"
  end
end
