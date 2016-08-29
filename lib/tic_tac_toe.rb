board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board (board)
  puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index)
    return false
  elsif index.between?(0,8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  value = current_player(board)
  if valid_move?(board, index)
    move(board, index, value)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count{|x| x if x == "X" || x == "O"}
end

def current_player(board)
 if turn_count(board)%2==0
    return "X"
 else
    return "O"
  end
end

    def won?(board)
      WIN_COMBINATIONS.each do |wins|
      if (board[wins[0]] == "X" && board[wins[1]] == "X" && board[wins[2]] == "X") || (board[wins[0]] == "O" && board[wins[1]] == "O" && board[wins[2]] == "O")
        return wins
      end
      end

      if board.each do |e|
        e == " "
        return false
      end
    end

    end


    def full?(board)
      if board.detect{|i| i == " "}
        return false
      else
        return true
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
      if won?(board)
        return true
      elsif draw?(board)
        return true
      elsif full?(board)
        return true
      else
        return false
      end
    end

    def winner(board)
      if won?(board)
        return board[won?(board)[0]]
      end
    end

    def play(board)
      while !over?(board)
        turn(board)
      end
      if winner(board) == "X"
        puts "Congratulations X!"
      elsif
        puts "Congratulations O!"
      elsif draw?(board)
        puts "Cats Game!"
      end
    end
