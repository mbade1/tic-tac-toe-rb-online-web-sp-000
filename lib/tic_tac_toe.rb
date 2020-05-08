require "pry"

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
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i
  return index - 1
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    return true
  end
end


def turn_count(board)
  counter = 0
  board.each do |spaces|
    if spaces == "X" || spaces == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end


def turn(board)
  puts "Please enter 1-9:"
  index = gets.chomp
  index = input_to_index(index)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    puts display_board(board)
  else 
    puts "That is an invalid entry!"
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if board[win_combination[0]] == board[win_combination[1]] &&
      board[win_combination[1]] == board[win_combination[2]] &&
      position_taken?(board, win_combination[0])
      return win_combination
    end
  end
  false
end

def full?(board)
  board.all? {|i| i == "X" || i == "O"}
end


def draw?(board)
   full?(board) && !won?(board)
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
end

def winner(board)
   if won?(board)
      return board[won?(board)[0]]
   end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board) 
    winner(board) == "X" || winner(board) == "O"
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
      puts "Cat's Game!"
  end
end

#until the game is over
  #players keep taking turns
#plays the first few turns of the game...
#if there's a winner
  #see who the winner is
    #congratulate them!
  #if there's a draw
    #tell the players there is a draw.
