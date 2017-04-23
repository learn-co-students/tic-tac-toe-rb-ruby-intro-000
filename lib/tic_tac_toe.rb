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

def input_to_index(input)
  index = input.to_i - 1
end

def move (board,index,character = "X")
  board[index] = character
  board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  if (index.between?(0,8) == true && position_taken?(board,index) == false)
    true
  elsif (index.between?(0,8) == false || position_taken?(board,index) == true)
    false
  end  
end