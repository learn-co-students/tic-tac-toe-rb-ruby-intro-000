def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (user_input)
  index = (user_input.to_i - 1)
end

def move (board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ") #if either of these are true, then it is FALSE. (not taken)
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index) # TRUE if BOTH move is on board and if position is NOT taken (true that it is false)
end


#DEFINE CURRENT PLAYER
def turn_count(board)
  count = 0
  board.each do |turns|
    if turns == "X" || turns == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
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

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def won?(board)
  WIN_COMBINATIONS.each do |wincombo|
    if (board[wincombo[0]]) == "X" && (board[wincombo[1]]) == "X" && (board[wincombo[2]]) == "X"
      return wincombo
    elsif (board[wincombo[0]]) == "O" && (board[wincombo[1]]) == "O" && (board[wincombo[2]]) == "O"
      return wincombo
    end
  end
  return false
end

def full?(board)
  board.none? {|positions| positions == " "}
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  player = won?(board) #just setting the wincombo array from before to new variable
  if player #is true (aka array for winning combo was returned because someone won. otherwise would be false if no winner)
    if board[player[0]] == "X" #we already know that that is the winning combo positions so use that to index into the board to see what the value was at that position
      return "X"
    elsif board[player[0]] == "O"
      return "O"
    end
  end
end

# PLAY method below

def play(board)
  total_turns = 0
  while total_turns < 9
    if over?(board)
      if won?(board)
        puts "Congratulations #{winner(board)}!"
      elsif draw?(board) || full?(board)
        puts "Cat's Game!"
      end
      return
    end
    turn(board)
    total_turns += 1
  end
end
