
WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7],
[2, 5, 8], [0, 4, 8], [2, 4, 6]]



def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input = (input.to_i - 1)

  return input
end


def move(board, input, character)
  board[input] = character
end

def position_taken?(board, index)
  if board[index] == " "
    return false
  elsif board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if (position_taken?(board, index) == false) && (index <= 8) && (index >= 0)
    return true
  elsif (position_taken?(board, index) == true) || (index > 8) || (index < 0)
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"

  input = gets.strip

  index = input_to_index(input)

  if valid_move?(board, index) == true
    move(board, index, current_player(board))
  elsif valid_move?(board, index) == false
    turn(board)
  end

  display_board(board)
end

def turn_count(board)
  counter = 0

  board.each do |square|
    if (square == "X") || (square == "O")
      counter += 1
    end
  end

  return counter
end

def current_player(board)
  character = nil
  if turn_count(board) % 2 == 0
    character = "X"
  elsif turn_count(board) % 2 == 1
    character = "O"
  end
  return character
end

def won?(board)
  WIN_COMBINATIONS.each do |position|
    if (board[position[0]] == "X") && (board[position[1]] == "X") && (board[position[2]] == "X")
      return position
    elsif (board[position[0]] == "O") && (board[position[1]] == "O") && (board[position[2]] == "O")
      return position
    end
  end
  return false
end

def full?(board)
  if board.all? do |spot|
    (spot != " ") && (spot != "")
    end
    return true
  else
    return false
  end
end

def draw?(board)
  if !(won?(board)) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  winner = nil
  if won?(board)
    WIN_COMBINATIONS.each do |position|
      if (board[position[0]] == "X") && (board[position[1]] == "X") && (board[position[2]] == "X")
        winner = "X"
      elsif (board[position[0]] == "O") && (board[position[1]] == "O") && (board[position[2]] == "O")
        winner = "O"
      end
    end
  end

    return winner
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
