



WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # Left column
    [1,4,7], # Middle column
    [2,5,8], # Right column
    [0,4,8], # Diagonal 1
    [2,4,6]  # Diagonal 2
]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
    index = input.to_i - 1
end

def move(board, index, character)
    board[index] = character
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
    if index.between?(0,8) && !position_taken?(board, index)
        true
    else
        false
    end
end

def turn(board)
    puts "Please enter 1-9:"
    index = gets.strip
    index = input_to_index(index)
    character = current_player(board)
    if valid_move?(board, index)
        move(board, index, character)
        display_board(board)
    else
        turn(board)
    end
end

def turn_count(board)
    filled = board.select {|space| space == "X" || space == "O"}
    filled.length
end

def current_player(board)
    if turn_count(board) % 2 == 0
        return "X"
    else
        return "O"
    end
end

def won?(board)
    WIN_COMBINATIONS.each do |win_combo|
        if board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X"
            return win_combo
        elsif board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O"
            return win_combo
        end
    end
    return false
end

def full?(board)
    board.all? do |space|
        if space == "X" || space == "O"
            true
        else
            false
        end
    end
end

def draw?(board)
    if !won?(board) && full?(board)
        true
    else
        false
    end
end

def over?(board)
    if won?(board) || draw?(board)
        true
    else
        false
    end
end

def winner(board)
    winning_row = won?(board)
    if won?(board)
        board[winning_row[0]]
    else
        nil
    end
end

def play(board)
    turn_counter = 1
    while !over?(board)
        turn(board)
        turn_counter += 1
    end
    if won?(board)
        puts "Congratulations #{winner(board)}!"
    else
        puts "Cats Game!"
    end
end
