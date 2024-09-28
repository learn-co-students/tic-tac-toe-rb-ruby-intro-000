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
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
    user_input.to_i - 1
end

def position_taken?(board, index)
    board[index] != " "
end

def valid_move?(board, index)
    return true if (index.between?(0, 8) && !position_taken?(board, index))
end

def move(board, index, token)
    board[index] = token
end

def turn_count(board)   
    turns_played = 0
    board.map do |element|
        turns_played += 1 if (element == "X" || element == "O")
    end
    turns_played 
end

def current_player(board)
    if (turn_count(board) % 2 == 0)
        return "X"
    else 
        return "O"
    end
end

def turn(board)
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if (valid_move?(board, index))
        move(board, index, current_player(board))
        display_board(board)
    else
        turn(board)
    end
end

def won?(board)
    WIN_COMBINATIONS.each do | combination |
        win_index_1 = combination[0]
        win_index_2 = combination[1]
        win_index_3 = combination[2]
        
        position_1 = board[win_index_1] 
        position_2 = board[win_index_2] 
        position_3 = board[win_index_3] 
        
        if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return combination 
        elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return combination
        end
    end
    return false
end

def full?(board)
    board.all? do | element |
      element == "X" || element == "O"
    end
end
  
def draw?(board)
    return true if (full?(board) && !won?(board))
end
  
def over?(board)
    return true if won?(board) || full?(board) || draw?(board)
end
  
def winner(board)
    if (won?(board))
        winning_combination = won?(board)
        position_1 = board[winning_combination[0]] 
        if (position_1 == "X")
            return "X"
        elsif (position_1 == "O")
            return "O"
        else 
            return nil
        end
    end
end

def play(board)
    until over?(board)
        turn(board)
    end
    if (won?(board))
        puts "Congratulations #{winner(board)}!"
    elsif (draw?(board))
        puts "Cat's Game!"
    end
end

 



