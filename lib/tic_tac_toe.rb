

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


def display_board(board)
  puts" #{board[0]} | #{board[1]} | #{board[2]} "
  puts"-----------"
  puts" #{board[3]} | #{board[4]} | #{board[5]} "
  puts"-----------"
  puts" #{board[6]} | #{board[7]} | #{board[8]} "
end

board=["  ","  ","   ","   ","  ","   ","  ","  ","  "]


def input_to_index(user_input)
  input = user_input.to_i
  index = input - 1
end


def move(board, index, player)
  board[index] = player
end


def position_taken?(board, index)
  !(board[index] == " " || board[index] =="" || board[index].nil?)
end


def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board, index) == false
    return true
    else
      return false
    end
  end


def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = user_input.to_i - 1
  input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, "X")
    display_board(board)
  else
    turn(board)
  end
end


def turn_count(board)
  c=0
  board.each do|bd|  if bd =="X"||bd =="O"
    c+=1
    end
  end
  c
end



def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
    else
      return "O"
      end
    end




def won?(board)
  WIN_COMBINATIONS.each do|win|
    win_index_1 = win[0]
    win_index_2 = win[1]
    win_index_3 = win[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return true
      elsif  position_1 == "O" && position_2 == "O" && position_3 == "O"
        return true
        end
      end
      return false
    end



def full?(board)
  board.all?{|token| token == "X" || token == "O"}
  end



def draw?(board)
  if !won?(board) && full?(board)
    return true
    else
      false
    end
  end



def over?(board)
  draw?(board)||board
  full?(board)
  end



def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
  win_index_0 = win_combination[0]
  win_index_1 = win_combination[1]
  win_index_2 = win_combination[2]
  if board[win_index_0] == "X" && board[win_index_1] == "X" && board[win_index_2] == "X"
    return "X"
    elsif board[win_index_0] == "O" && board[win_index_1] == "O" && board[win_index_2] == "O"
      return "O"
      elsif !won?(board)
        return nil
      else
      end
    end
  end




def play(board)
  turn(board)
  if draw?(board) && over?(board) == false
    puts "Cats Game!"
  elsif over?(board) && won?(board)
      puts "Congratulations #{winner(board)}!"
      else
      end
    end




  # +  end
  # +end          #elsif (board ==" " || board ==""

#
# def play(board)
#   c = 0
#   while c<9
#     if over?(board)||draw?(board)
#     elsif won?(board)
#       puts "Congratulations #{winner(board)}!"
#       elsif draw?(board)
#         puts "Cats Game!"
#         c+=1
#         end
#       end
#     end
#



# def plays(board)
#   c = 0
#   while c < 9
#     turn(board)
#     c += 1
#   end
# end
#
#
# def play(board)
#   c=0
#   while c<9
#     turn(board)
#     if over?(board) || draw?(board)
#       puts"Cats Game!"
#     end
#
#       c+=1
#       else won?(board)
#         puts "Congratulations #{winner(board)}!"
#       end
#     end
#
    # user_input = gets.strip
    # draw?(board)
    # over?(board)
  #  c+=1
  #end

  # if won?(board)
  #   puts "Congratulations #{winner(board)}!"
  #   elsif draw?(board)
  #     puts "Cats Game!"
  #     end
  #   end
  # #
  # def play(board)
  #
  #   over?(board)
  #   turn(board)
  #   end
  #   if won?(board)
  #     puts "Congratulations #{winner(board)}!"
  #     elsif draw?(board)
  #       puts "Cats Game!"
  #     end
  #   end





          # #return true
          # +WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7],
          # +[2, 5, 8], [0, 4, 8], [2, 4, 6]]
          # +
          # +
          # +
          # +def display_board(board)
          # +    puts " #{board[0]} | #{board[1]} | #{board[2]} "
          # +    puts "-----------"
          # +    puts " #{board[3]} | #{board[4]} | #{board[5]} "
          # +    puts "-----------"
          # +    puts " #{board[6]} | #{board[7]} | #{board[8]} "
          # +end
          # +
          # +def input_to_index(input)
          # +  input = (input.to_i - 1)
          # +
          # +  return input
          # +end
          # +
          # +
          # +def move(board, input, character)
          # +  board[input] = character
          # +end
          # +
          # +def position_taken?(board, index)
          # +  if board[index] == " "
          # +    return false
          # +  elsif board[index] == "" || board[index] == nil
          # +    return false
          # +  else
          # +    return true
          # +  end
          # +end
          # +
          # +def valid_move?(board, index)
          # +  if (position_taken?(board, index) == false) && (index <= 8) && (index >= 0)
          # +    return true
          # +  elsif (position_taken?(board, index) == true) || (index > 8) || (index < 0)
          # +    return false
          # +  end
          # +end
          # +
          # +def turn(board)
          # +  puts "Please enter 1-9:"
          # +
          # +  input = gets.strip
          # +
          # +  index = input_to_index(input)
          # +
          # +  if valid_move?(board, index) == true
          # +    move(board, index, current_player(board))
          # +  elsif valid_move?(board, index) == false
          # +    turn(board)
          # +  end
          # +
          # +  display_board(board)
          # +end
          # +
          # +def turn_count(board)
          # +  counter = 0
          # +
          # +  board.each do |square|
          # +    if (square == "X") || (square == "O")
          # +      counter += 1
          # +    end
          # +  end
          # +
          # +  return counter
          # +end
          # +
          # +def current_player(board)
          # +  character = nil
          # +  if turn_count(board) % 2 == 0
          # +    character = "X"
          # +  elsif turn_count(board) % 2 == 1
          # +    character = "O"
          # +  end
          # +  return character
          # +end
          # +
          # +def won?(board)
          # +  WIN_COMBINATIONS.each do |position|
          # +    if (board[position[0]] == "X") && (board[position[1]] == "X") && (board[position[2]] == "X")
          # +      return position
          # +    elsif (board[position[0]] == "O") && (board[position[1]] == "O") && (board[position[2]] == "O")
          # +      return position
          # +    end
          # +  end
          # +  return false
          # +end
          # +
          # +def full?(board)
          # +  if board.all? do |spot|
          # +    (spot != " ") && (spot != "")
          # +    end
          # +    return true
          # +  else
          # +    return false
          # +  end
          # +end
          # +
          # +def draw?(board)
          # +  if !(won?(board)) && full?(board)
          # +    return true
          # +  else
          # +    return false
          # +  end
          # +end
          # +
          # +def over?(board)
          # +  if won?(board) || draw?(board)
          # +    return true
          # +  else
          # +    return false
          # +  end
          # +end
          # +
          # +def winner(board)
          # +  winner = nil
          # +  if won?(board)
          # +    WIN_COMBINATIONS.each do |position|
          # +      if (board[position[0]] == "X") && (board[position[1]] == "X") && (board[position[2]] == "X")
          # +        winner = "X"
          # +      elsif (board[position[0]] == "O") && (board[position[1]] == "O") && (board[position[2]] == "O")
          # +        winner = "O"
          # +      end
          # +    end
          # +  end
          # +
          # +    return winner
          # +end
          # +
          # +def play(board)
          # +  until over?(board)
          # +    turn(board)
          # +  end
          # +
          # +  if won?(board)
          # +    puts "Congratulations #{winner(board)}!"
          # +  elsif draw?(board)
          # +    puts "Cats Game!"
          # +  end
          # +end          #elsif (board ==" " || board ==""
