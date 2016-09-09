# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

def won?(board)
    spotIndx = [0,1,2,3,4,5,6,7,8,9].select do |spot|
        position_taken?(board, spot)
    end

    if spotIndx==[]
        winingCombo = nil
    else
        winingCombo = WIN_COMBINATIONS.detect do |oneCombo|

            onlyX=oneCombo.all? do |single|
                spotIndx.include?(single) && board[single]=="X"
            end

            onlyO=oneCombo.all? do |single|
                spotIndx.include?(single) && board[single]=="O"
            end

            [onlyX, onlyO].detect{|i| i}

        end
    end

    if !(winingCombo.nil? || winingCombo == [])
        winingCombo
    else
        false
    end
end

def full?(board)
    board.all? do |spot|
        spot == "X" || spot == "O"
    end
end

def draw?(board)
    if !!won?(board)
        false
    else
        full?(board)
    end
end

def over?(board)
    !!won?(board) || draw?(board) || full?(board)
end

def winner(board)
    if !!won?(board)
        board[won?(board)[0]]
    else
        nil
    end
end

def current_player(board)
    if turn_count(board)%2==0
        "X"
    else
        "O"
    end
end

def turn_count(board)
    counter = 0
    board.each do |spot|
        if spot == "X" || spot == "O"
            counter += 1
        end
    end
    counter
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

def position_taken?(board, location)
    board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
        move(board, index, current_player(board))
        display_board(board)
    else
        turn(board) #self called!
    end
end

# Define your play method below
def play(board)
    until over?(board) do
        turn(board)
    end

    if !draw?(board)
        puts "Congratulations #{winner(board)}!"
    else
        puts "Cats Game!"
    end
end
