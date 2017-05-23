WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,4,8],  # Left diagonal
  [2,4,6],  # Right diagonal
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8]  # Right column
  # An array for each win combination
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
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if (position != " ") && (position != "") &&  (position != nil)
      counter += 1
   end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
   WIN_COMBINATIONS.detect do |win_combination|
     win_index_1 = win_combination[0]
     win_index_2 = win_combination[1]
     win_index_3 = win_combination[2]

     position_1 = board[win_index_1]
     position_2 = board[win_index_2]
     position_3 = board[win_index_3]

     if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
       win_combination
     end
   end
 end

 def full?(board)
    [0,1,2,3,4,5,6,7,8].all?{|position| position_taken?(board, position)} #Why not board.all?
  end

  def draw?(board)
    !won?(board) && full?(board) == true
  end


  def over?(board)
    if won?(board) != nil
      true
    elsif draw?(board) == true
      true
    else full?(board) == false
      false
    end
  end

  def winner(board)
       if won?(board) != nil
          won = won?(board)
          return board[won[0]]
        end
      end

  def play(board)
      until over?(board)
       turn(board)
     end
      puts "Cats Game!" if draw?(board) #Why not add = true?
      puts "Congratulations #{winner(board)}!" if won?(board)
    end
