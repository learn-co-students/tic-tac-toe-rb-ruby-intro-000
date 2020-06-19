WIN_COMBINATIONS = [
  [0,1,2], # Top row
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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, position, token)
 board[position] = token
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == nil
    return false
  else return true
  end
end

def valid_move?(board, position)
if position_taken?(board, position) == false && 0 <= position.to_i && position.to_i <= 8
  return true
else return false
end
end

def turn(board)
  loop do
    puts "Please enter 1-9"
  user_input = gets.chomp
  position = input_to_index(user_input)
if valid_move?(board, position) == true
  board[position] = current_player(board)
  display_board(board)
  break
  end
puts "invalid move"
end
end



def turn_count(board)
  i = 0
  board.each {|x|
    if x != " " && x != nil
      i += 1
    end
    }
    return i
end

def current_player(board)
if turn_count(board) % 2 == 0
  return "X"
else return "O"
end
end

def won?(board)
    i = 0
WIN_COMBINATIONS.each {|sub_array|
  if (board[sub_array[0]] == board[sub_array[1]]) && (board[sub_array[1]] == board[sub_array[2]]) && (board[sub_array[0]] != " " && board[sub_array[0]] != nil)
    i += 1
    return true
end
}
if i == 0
  return false
end
end

def full?(board)
  board.any? {|x|
if (x == " " || x == nil)
 return false
end }
board.none? {|y|
 y == " " || y == nil}
end

def draw?(board)
if full?(board) && !(won?(board))
     return true
   else return false
   end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else return false
  end
end


def winner(board)
  i = 0
  WIN_COMBINATIONS.each {|sub_array|
    if (board[sub_array[0]] == board[sub_array[1]]) && (board[sub_array[1]] == board[sub_array[2]]) && (board[sub_array[0]] != " " && board[sub_array[0]] != nil)
          return board[sub_array[0]]
          i += 1
        end
      }
        if 1 == 0
          return nil
 end
end

def play(board)
  until over?(board) == true
turn(board)
end
if draw?(board) == true
  puts "Cat's Game!"
end
if won?(board) == true
  player = winner(board)
  puts "Congratulations #{player}!"
  display_board(board)
end
end
