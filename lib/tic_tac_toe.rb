def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,4,8],
  [6,4,2],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def won?(board)
  combo = WIN_COMBINATIONS.detect do |win_combination|
    win_combination.all? do |index|
      if board[index]=="X"
        true
      end
    end
  end
  if combo == nil
    combo = WIN_COMBINATIONS.detect do |win_combination|
      win_combination.all? do |index|
        if board[index]=="O"
          true
        end
      end
    end
  end
  return combo
end

def full?(board)
  board.all? do |move|
    if move=="X" || move=="O"
      true
    else
      false
    end
  end
end

def draw?(board)
  if won?(board)==nil && full?(board)==true #draw
    true
  else
    false
  end
end

def over?(board)
  if draw?(board) == true || won?(board)!=nil || full?(board)==true
    true
  else
    false
  end
end

def winner(board)
  if won?(board)==nil
    nil
  else
    index=won?(board)[0]
    return board[index]
  end
end

def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (user_input)
  index = user_input.to_i - 1
end

def move (board, index,character)
    board[index] = character
end

def valid_move? (board, index)
    if index < 0 || index > 8
        false
    elsif (board[index] == " " || board[index] == "" || board[index] == nil)
        true
    else
      false
    end
end

def turn (board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    character=current_player(board)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  spots=board.select {|spot| spot!=" "}
  spots.count
end

def current_player(board)
  if turn_count(board).odd?
    "O"
  else
    "X"
  end
end

def play(board)
  if over?(board)==false
    turn(board)
    play(board)
  else
    if draw?(board)
      puts "Cat's Game!"
    elsif won?(board)!=nil
      puts "Congratulations #{winner(board)}!"
    end
  end
end
