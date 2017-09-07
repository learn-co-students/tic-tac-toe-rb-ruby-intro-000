
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
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

def move(board, index, player_token)
  board[index]= player_token
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  board.count {|token| token== "X"|| token== "O"}
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

def won? (board, win_possibility = WIN_COMBINATIONS)
  if board.all?{|slot| slot.include?("X" || "O")}
    return false
  elsif board.all?{|slot| slot.include?("X" || "O")}
    return false
  else
    o_index_arr=[]
  x_index_arr=[]
  board.each_index do |slot|
    if board [slot] == "O"
      o_index_arr << slot
    elsif board [slot] == "X"
      x_index_arr << slot
    end
  end

  counter=0
  while counter != 8
    if    (WIN_COMBINATIONS[counter] - o_index_arr).empty?
      return WIN_COMBINATIONS[counter]
    elsif (WIN_COMBINATIONS[counter] - x_index_arr).empty?
      return WIN_COMBINATIONS[counter]
    end
    counter += 1
  end
end
end

def full?(board)
  if board.all? { |slot| slot == "X" || slot == "O" }
    true
  else
    false
  end
end

def who_won?(board)
    o_index_arr=[]
    x_index_arr=[]
    board.each_index do |slot|
      if board [slot] == "O"
        o_index_arr << slot
      elsif board [slot] == "X"
        x_index_arr << slot
      end
    end

    counter=0
    while counter != 8
      if    (WIN_COMBINATIONS[counter] - o_index_arr).empty?   # O  winner?
        return "O won"
      elsif (WIN_COMBINATIONS[counter] - x_index_arr).empty?   # X  winner?
        return "X won"
      end
      counter += 1
    end
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  end
end

def winner(board)
  if won?(board)
    winner_board = won?(board)
    return board[winner_board[0]]
  end
end


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
