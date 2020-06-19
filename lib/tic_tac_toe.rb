WIN_COMBINATIONS = [
  [0, 1, 2],
  [0, 4, 8],
  [0, 3, 6],
  [3, 4, 5],
  [6, 4, 2],
  [1, 4, 7],
  [6, 7, 8],
  [2, 5, 8]
]

board = ["X", "X", "X", "X", "X", "X", "X", "X", "X"]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    false
  elsif
    board[index] == "X" || board[index] == "O"
    true
  else
    nil
  end
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0,8)
end

  def position_taken?(board, index)
    if board[index] == "" || board[index] == " " || board[index] == nil
      false
    elsif
      board[index] == "X" || board[index] == "O"
      true
    else
      nil
    end
  end

	def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board,index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn=0
  board.each do |token|
    if(token=="X" || token=="O")
      turn+=1
end
end
turn
end

def current_player(board)
  turn_count(board) % 2 == 0? "X": "O"
end

def won?(board)
  winning_combination = WIN_COMBINATIONS.detect do |combination|
    board[combination[0]] != " " && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]
end
end

def full?(board)
  (board).none?{|i| i == " "}
end

def draw?(board)
  full?(board) && !won?(board)
  end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  winning_combination = won?(board)
  if winning_combination
    board[winning_combination[0]]
  else
    nil
  end
end

def play(board)
	until over?(board)
		turn(board)
	end
	if won?(board)
		if value = "X"
			puts "Congratulations X!"
		end
		if value = "O"
			puts "Congratulations O!"
		end
	else draw?(board)
		puts "Cat's Game!"
	end
end
