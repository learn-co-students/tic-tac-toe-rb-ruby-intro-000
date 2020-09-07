# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS =[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won? (board)
  WIN_COMBINATIONS.detect do |check|
    position_taken?(board,check[0]) && board[check[0]]==board[check[1]] && board[check[1]]==board[check[2]]
  end
end

def full? (board)
  board.all? {|check| check!=" "}
end

def draw? (board)
  !won?(board) && full?(board)
end

def over? (board)
  won?(board) || draw?(board) || full?(board)
end

def winner (board)
  if over?(board)
    board[won?(board)[0]]
  end
end

def turn_count(board)
  turns_taken = 0
  board.each do |position|
    if position!=" "
      turns_taken+=1
    end
  end
  return turns_taken
end

def current_player(board)
  if turn_count(board)%2==0; "X"; else "O"; end
end

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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

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
