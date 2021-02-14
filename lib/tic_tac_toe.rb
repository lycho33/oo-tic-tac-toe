require 'pry'
class TicTacToe

    def initialize
        @board = Array.new(9, " ")
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(string)
        string.to_i - 1
    end

    def move(index, token)
        @board[index] = token
    end

    def position_taken?(index)
        if @board[index] == " "
            false
        else
            true #the position is taken
        end 
    end

    def valid_move?(index)
        !self.position_taken?(index) && index.between?(0, 8) 
        #!self.position_taken?(index) inverses T/F so if position is taken then it's not a valid move
    end

    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end

    def current_player 
        turn_count % 2 == 0 ? "X" : "O"
        #if it's even -- X, if odd -- O
    end

    def turn
        puts "Put a number between 1 - 9"
        input = gets.strip
        index = input_to_index(input)
      
        if valid_move?(index)
            token = current_player
            move(index, token)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.any? do |win|
            if position_taken?(win[0]) && @board[win[0]] == @board[win[1]] && @board[win[2]] == @board[win[0]] #if the position is taken, then index 0 in the winning combo is X will = index 1 = X && index 2 =X or index 3
                return win
            end
            false
        end
    end

    def full?
        @board.all? {|space | space != " "}
    end

    def draw? 
        full? && !won? #if the board is full && doesn't ! equal a win -- draw
    end

    def over?
        if draw? == true
            true
        elsif won?
            true
        else 
            false
        end
    end

    def winner
        if won?
            @board[won?[0]]
        else
            nil
        end
    end

    def play
        turn until over?
        if winner == "X"
            puts "Congratulations X!"
        elsif winner == "O"
            puts "Congratulations O!"
        else 
            puts "Cat's Game!"
        end
    end
end