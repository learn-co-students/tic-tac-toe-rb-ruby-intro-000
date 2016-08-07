
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

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index=input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  if
    board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    board[index] == "X" || board[index] == "O"
    return true
  end
end

def valid_move?(board, index)
  if
    position_taken?(board, index) || index < 0 || index > 8
    return false
  else
    index >= 0 && index <=8
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
    if valid_move?(board, index) == true
      move(board, index, value="X")
      display_board(board)
    else
      turn(board)
    end
end

def turn_count(board)
  number_of_turns = 0
  board.each do |turns|
    if turns == "X" || turns == "O"
    number_of_turns += 1
    end
  end
  return number_of_turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    current_player = "X"
  else
    current_player = "O"
  end
end

def won?(board)
      if WIN_COMBINATIONS.each do |win_combination|

        position_1 = board[win_combination[0]]
        position_2 = board[win_combination[1]]
        position_3 = board[win_combination[2]]

        if
          position_1 == "X" && position_2 == "X" && position_3 == "X"
          return win_combination
        elsif
          position_1 == "O" && position_2 == "O" && position_3 == "O"
          return win_combination
        end
      end
      else
        return false
      end
  end

  def full?(board)
    board.all? do |play|
      play == "X" || play == "O"
    end
  end

  def draw?(board)
    if !won?(board) && full?(board)
      return true
    else
      return false
    end
  end

  def over?(board)
    full?board || won?(board) || draw?(board)
  end

  def winner(board)
      if won?(board)
      win_combination = won?(board)
      board[win_combination[0]]
    end
  end

  def play(board)
    while !over?(board)
      turn(board)
    end
    if won?(board)
      puts "Congratulations!"
    elsif draw?(board)
        puts "Cat's Game!"
    end
  end
