class TicTacToe
    def initialize()
        @board = Array.new(9, " ")
    end

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

    def display_board()
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token="X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == " " || nil ? false : true
    end

    def valid_move?(index)
        index >= 0 && index < @board.length && !position_taken?(index) ? true : false
    end

    def turn()
        puts "Choose your next move (1-9): "
        user_input = gets.chomp
        user_index = input_to_index(user_input)
        if valid_move?(user_index)
            move(user_index, current_player())
            display_board()
        else
            puts "That's not a valid move. Try again."
            turn()
        end
    end

    def turn_count()
        @board.count { |i| i == "X" || i == "O" }
    end

    def current_player()
        turn_count() % 2 == 0 ? "X" : "O"
    end

    def won?()
        WIN_COMBINATIONS.each do | combo |
            first, second, third = combo[0], combo[1], combo[2]
            if position_taken?(first) &&
               @board[first] == @board[second] &&
               @board[first] == @board[third]
                   return combo
            end
        end
        false
    end

    def full?()
        !@board.any?(" ")
    end

    def draw?()
        !won?() && full?() ? true : false
    end

    def over?()
        won?() || draw?() ? true : false
    end

    def winner()
        if combo = won?()
            @board[combo[0]] 
        end
    end

    def play()
        until over?()
            turn()
        end

        won?() ? (puts "Congratulations #{winner()}!") : (puts "Cat's Game!")
    end
end