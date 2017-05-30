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
    puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  input_to_index = user_input.to_i - 1
end


def move (board, input_to_index, value)
  board[input_to_index] = value
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move?(board,index)
  !position_taken?(board,index) && index.between?(0,8)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if !valid_move?(board, index)
    turn(board)
  else
  turn_count(board)
  player_token = current_player(board)
  move(board, index, player_token)
  display_board(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |value|
    if value == "X" || value == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn = turn_count(board)
  if turn % 2 == 0
  value = "X"
  else value = "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
      board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]] && position_taken?(board, win_combination[0]) == true
      end
end

def full?(board)
  board.all? do |index_value|
    index_value == "X" || index_value == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if win_combination = won?(board)
    board[win_combination[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  else
  winner = winner(board)
  puts "Congratulations #{winner}!"
  end
end
