WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-------------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-------------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, position, player_token)
  board[position] = player_token
end

# Is the position occupied by a token
def position_taken?(board, position)
  !(board[position] == " ")
end

def valid_move?(board, position)
  position.between?(0, 8) && !position_taken?(board, position)
end

def turn_count(board)
    board.count { |pos| pos != " " }
end

def current_player(board)
    turn_count(board).even? ? "X" : "O"
end

def turn(board)
  puts "Please choose a position 1-9:"
  user_input = gets.strip
  converted = input_to_index(user_input)
  player_token = current_player(board)

  until valid_move?(board, converted)
    puts "Please choose a position 1-9:"
    player_input = gets.strip
    converted = input_to_index(player_input)
  end

  move(board, converted, player_token)
  display_board(board)
end

def won?(board)
    WIN_COMBINATIONS.each do |winn_combo|
        if board[winn_combo[0]] == "X" && board[winn_combo[1]] == "X" && board[winn_combo[2]] == "X"
            return winn_combo
        elsif board[winn_combo[0]] == "O" && board[winn_combo[1]] == "O" && board[winn_combo[2]] == "O"
            return winn_combo
        end
    end

    false
end

def full?(board)
    board.none? { |pos| pos == " " }
end

def draw?(board)
    if full?(board) && !won?(board)
        return true
    elsif !won?(board)
        return false
    elsif won?(board)
        return false
    end
end

def over?(board)
    if won?(board) || full?(board) || draw?(board)
        return true
    else
        false
    end
end

def winner(board)
    !won?(board) ? nil : board[won?(board)[0]]
end

def play(board)
    until over?(board)
        turn(board)
    end

    if winner(board) == nil
        puts "Cat's Game!"
    else
        puts "Congratulations #{winner(board)}!"
    end
end
