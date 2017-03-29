# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Left diagonal
  [2,4,6], # Right diagonal
]

def won?(board)
no_win = true
  WIN_COMBINATIONS.each do |win_array|
    win = []
    win_array.select do |position|
      if position_taken?(board, position)
        win << position
        if win.length == 3 && win_array == win && (board[win[0]] == board[win[1]] && board[win[0]] == board[win[2]])
          no_win = false
          return win_array
        end
      end
    end
  end
  if no_win
   false
  end
end

def full?(board)
  [0,1,2,3,4,5,6,7,8].all?{|position| position_taken?(board, position)}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  !full?(board) && !won?(board) ? false : true
end

def winner(board)
  !won?(board) ? nil : won?(board).detect{|position| return board[position]}
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
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

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
index = 9
  until valid_move?(board, index)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def play(board)
  until over?(board) || draw?(board) || won?(board)
    turn(board)
    draw?(board)
  end
  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
