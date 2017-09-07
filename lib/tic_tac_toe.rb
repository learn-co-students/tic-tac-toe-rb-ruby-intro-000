#Winning COmbos
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

# Define your play method below
def play(board)
	while !over?(board)
    turn(board)
	end
	if won?(board)
		puts "Congratulations #{winner(board)}!"
	elsif draw?(board)
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

def valid_move?(board, index)
  if index.between?(0,8)
    if !position_taken?(board, index)
      true
    end
  end
end

def full?(board)
	   if board.select {|item| item == " "} != []
	       return false
	   else
	       return true
	   end
end

def draw?(board)
		!won?(board) && full?(board)
end

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

def over?(board)
	won?(board) || draw?(board)
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

#board = ["O","O","O","O","O","O","O","O","O"]

#display_board(board)

def input_to_index(user_input)
  user_input = user_input.to_i - 1
end

def move(board, user_input, char) #char = "X"
  board[user_input] = char
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

def position_taken?(board, index)
  if (board[index] == " ") || (board[index] == "") || (board[index] == nil)
    false
  elsif (board[index] == "X") || (board[index] == "O")
    true
  end
end

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

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
	end
end
