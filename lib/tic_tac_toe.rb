WIN_COMBINATIONS =[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8],
]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input = (input.to_i) - 1
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def move(board,index,value = "X")
  board[index] = value
end

def valid_move?(board,index)
  if index.between?(0,8) && !position_taken?(board,index)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

    if valid_move?(board,index)
      move(board,index,value = "X")
      display_board(board)
    else
      turn(board)
    end
end

def turn_count(board)
  board.count {|token| token == "X" || token == "O"}
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X": "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |w_combinations|
    w_combinations.each do |win_index|
      win_index_1 = w_combinations[0]
      win_index_2 = w_combinations[1]
      win_index_3 = w_combinations[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return w_combinations
      end
    end
    end
    return false
end


def full?(board)
  board.all? {|ele| ele == "X" || ele == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  winning_combo = won?(board)
  if winning_combo == false
    nil
  elsif winning_combo[0] == 0
    "X"
  else
    "O"
  end
end
