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


def play(board)
  i=0
  until over?(board)
    turn(board)
  end
  if draw?(board)
   puts "Cats Game!"
  else
   puts "Congradulations #{winner(board)}!"
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == 'X' || position == 'O'
      counter += 1
    end
  end
  return counter
end
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
                    [0,1,2],#top_row_win
                    [3,4,5],#middle_row_win
                    [6,7,8],#bottom_row_win
                    [0,3,6],#left_col_win
                    [1,4,7],#middle_col_win
                    [2,5,8],#right_col_win
                    [0,4,8],#diagonal_1_win
                    [2,4,6] #diagonal_2_win
                  ]

def won?(board)
  a=false
  WIN_COMBINATIONS.each do |i|
    if board[i[0]]=="X" && board[i[1]]=="X" && board[i[2]]=="X"
      a= i
    end
    if board[i[0]]=="O" && board[i[1]]=="O" && board[i[2]]=="O"
      a= i
    end
  end
  return a
end

def full?(board)
  return board.all?{|i| !(i.nil? || i == " ") }
end

def draw?(board)
  if full?(board)
    return !won?(board)
  else
    return false
  end
end


def over?(board)
  if draw?(board)
    return true
  elsif won?(board)==false
    return false
  else
    return true
  end
end

def winner(board)
  if won?(board)==false
    return nil
  else
    board[won?(board)[0]]
  end
end
