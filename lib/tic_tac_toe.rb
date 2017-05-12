# Define your WIN_COMBINATIONS constant
#
WIN_COMBINATIONS = [
	[0,1,2],
	[6,7,8],
	[3,4,5],
	[0,3,6],
	[2,5,8],
	[1,4,7],
	[0,4,8],
	[2,4,6]
]

winner_val =

def won?(board)
    WIN_COMBINATIONS.each do | wins |
        if ((board[wins[0]] == "X" && board[wins[1]] == "X" && board[wins[2]] == "X") ||
           (board[wins[0]] == "O" && board[wins[1]] == "O" && board[wins[2]] == "O"))
           winner_val = board[wins[0]]
        return wins
        else
            false
        end
     end
       return false
end

def full?(board)
    if board.select {|item| item == " "} != []
        return false
    else
        return true
    end
end

def draw?(board)
    if full?(board) == true && won?(board) == false
        return true
    else
        return false
    end
end

def over?(board)
    if won?(board) != false || draw?(board) == true
        return true
    else
        return false
    end
end


def winner(board)
  if won?(board) == false
    return nil
  elsif board[won?(board)[0]] == "X"
    return "X"
  elsif board[won?(board)[0]] == "O"
    return "O"
  end
end


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

board = ["O","O","O","O","O","O","O","O","O"]

display_board(board)

# code your input_to_index and move method here!


def input_to_index(user_input)
  user_input = user_input.to_i - 1
end

def move(board, user_input, char = "X")
  board[user_input] = char
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input = input_to_index(input)
  if valid_move?(board, input)
    move(board, input)
  else
    turn(board)
  end
  display_board(board)
end

def position_taken?(board, index)
  if (board[index] == " ") || (board[index] == "") || (board[index] == nil)
    false
  elsif (board[index] == "X") || (board[index] == "O")
    true
  end
end

position_taken?(board,0)

# code your #valid_move? method here
def valid_move?(board, index)
  if index.between?(0,8)
    if !position_taken?(board, index)
      true
    end
  end
  #index.between?(0,8) && !position_taken?(board, index)
end


# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
  board[index] != " "
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

turn_count(board)

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

current_player(board)

# Define your play method below
def play(board)
  count = 0
  while count != 9
    turn(board)
    count += 1
  end
end
