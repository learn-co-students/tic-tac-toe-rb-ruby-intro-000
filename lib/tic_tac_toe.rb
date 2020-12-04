def play(board)
  plays = 0
  while plays < 9 && !over?(board)
    turn(board, plays)
    plays += 1
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

def turn(board, round = 0)
#  if round  == 0 #|| current_player == "O"  *REDUNDANT CODE. REMOVED 12/4/20
  #  current_player = "X"
#    current_player_name = "Player 1"
#  else
  # current_player = "O"                *REDUNDANT CODE. REMOVED 12/4/20
#    current_player_name = "Player 2"
#  end
  puts "#{current_player(board)}, Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end



def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else return "O"
  end
end


def turn_count(board)
  turn_counter = 0
  board.each do |square|
    if square == "O" || square == "X"
      turn_counter += 1
    end
  end
  return turn_counter
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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


# Define your play method below



WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]



def over?(board)
  won?(board) || draw?(board) || full?(board)
end


def full?(board)
  !board.any?{|position| position == " " || position == "" || position = nil}
end


def draw?(board)
  full?(board) && !won?(board)
end


def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && combo.all?{|position| position_taken?(board, position)}
  end

#combo.all? do |position|
#  position_taken?(board, position)
#end
#combo.all?{|position| position_taken?(board, position)}

  #iterate on WIN_COMBINATIONS
  #all three of the winning combination are position_taken?
  #and
  #all three are the same token
  #and all three are a token
end


def winner(board)
#if winning combo exists, return the token in one of those cells.
  if won?(board)
    board[won?(board)[0]]
  end
end
