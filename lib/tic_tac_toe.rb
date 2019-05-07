WIN_COMBINATIONS = [
  [0,1,2],
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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
	puts "Please enter 1-9"
  input = gets.strip
  index = input_to_index(input)
	valid_move?(board, index) ? move(board, index, current_player(board)) : turn(board)
  display_board(board)
end

def turn_count(board)
	board.count { |n| n =="X" || n == "O" }
end

def current_player(board)
	turn_count(board).even? ? "X" : "O"
end

def won?(board)
	# check won combination
  WIN_COMBINATIONS.each do |combionation|
		if combionation.all? do |i|
				board[i] == "X"
			end
			#return wining x combination
			return combionation
		elsif
			combionation.all? do |i|
				board[i] == "O"
			end
			#return wining 0 combination
			return combionation
		end
  end
	# not won
	return false
end

def full?(board)
	#board.none? { |i| i == " " || i == "" }
	board.all? { |x| x == "X" || x == "O"}
end

def draw?(board)
	!won?(board) && full?(board)
end

def over?(board)
	won?(board) || draw?(board) || full?(board)
end

def winner(board)
	win_index = won?(board)
  if over?(board)
    board[win_index.first]
  end
end

def play(board)
	while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
	if draw?(board)
		puts "Cat's Game!"
	end
end
