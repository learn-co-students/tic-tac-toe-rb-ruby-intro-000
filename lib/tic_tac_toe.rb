
require 'pry'

WIN_COMBINATIONS = [
    [0,1,2],    # Top row
    [3,4,5],    # Middle row
    [6,7,8],    # Bottom row
    [0,3,6],    # Left column
    [1,4,7],    # Middle column
    [2,5,8],    # Right column
    [0,4,8],    # Left diagonal
    [2,4,6]     # Right diagonal

    # An array for each win combination
  ]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
    input.to_i - 1

end

def move(board, position, token)
    board[position] = token
end

def position_taken?(board, position)
    if board[position] == "X" || board[position] == "O"
        return true
    end
    false
end

def valid_move?(board, position)
    if !position.between?(0, 8)
        nil
    elsif !position_taken?(board, position) # == false
        true
    end
end

def turn(board)

    # Asking the user for their move by position 1-9.
    # Receiving the user input.
    # Convert user input to an index
    puts "Enter an empty board position, 1-9"
    position = gets.strip
    position = input_to_index(position)
    
    # If the move is valid, make the move and display board.
    # Otherwise (that is, if the move is invalid) ask for a new position until a valid move is received.
    if !valid_move?(board, position)
        return turn(board)
    end

    token = current_player(board)
    move(board, position, token)
    display_board(board)

end

def turn_count(board)
    board.count do |spot|
        spot == "X" || spot == "O"
    end
end

def current_player(board)
    if turn_count(board).even?
        token = "X"
    else
        token = "O"
    end
end

def won?(board)

    WIN_COMBINATIONS.each do |combo|

        if [board[combo[0]],board[combo[1]],board[combo[2]]] == ["X","X","X"] || [board[combo[0]],board[combo[1]],board[combo[2]]] == ["O","O","O"]
            return combo
        else
            
        end
      
    end
    false
    #  return false if there is no win combination present in the board and return the winning combination indexes as an array if there is a win

end

def full?(board)
    board.all? do |token|
        token == "X" || token == "O"
    end
end

def draw?(board)
    if full?(board) && !won?(board)
        true
    end
    # Build a method #draw? that accepts a board and returns true if the board has not been won and is full and false if the board is not won and the board is not full, and false if the board is won.
end

def over?(board)
    won?(board) || draw?(board) || full?(board)
    # Build a method #over? that accepts a board and returns true if the board has been won, is a draw, or is full.
end

def winner(board)
    if won?(board)
        board[won?(board)[0]]
    end
end

## Check the #play method by running:   rspec spec/02_play_spec.rb
def play(board)
    
    until over?(board)
        turn(board)
    end



    if won?(board)

        puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
        puts "Cat's Game!"
    end

end
