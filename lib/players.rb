class Player
    attr_reader :pieces, :player_number, :check
    def initialize(array, board_link, player_number)
        
        @board = board_link
        @player_number = player_number
        @pieces = generate_pieces(array)
        @check = false
    end

    def generate_pieces(array)

        set_pieces = []
        king =  King.new(array[0], self.player_number)
        queen = Queen.new(array[1], self.player_number)
        rook =  Rook.new(array[2], self.player_number)
        bishop = Bishop.new(array[3], self.player_number)
        knight = Knight.new(array[4], self.player_number)
        pawn =  Pawn.new(array[5], self.player_number)

        if player_number == 1
            @board.board[0].piece_holder = rook
            @board.board[1].piece_holder = knight
             @board.board[2].piece_holder = bishop
             @board.board[3].piece_holder = queen
             @board.board[4].piece_holder = king
             @board.board[5].piece_holder = bishop
             @board.board[6].piece_holder = knight
            @board.board[7].piece_holder = rook
             8.upto(15) do |i|
                 @board.board[i].piece_holder = pawn
             end
        elsif player_number == 2
            @board.board[56].piece_holder = rook
            @board.board[57].piece_holder = knight
            @board.board[58].piece_holder = bishop
            @board.board[59].piece_holder = queen
            @board.board[60].piece_holder = king
            @board.board[61].piece_holder = bishop
            @board.board[62].piece_holder = knight
            @board.board[63].piece_holder = rook
            48.upto(55) do |i|
                @board.board[i].piece_holder = pawn
            end
        end

        return set_pieces
    end
# display our players
    def render
        set_list = @pieces
        set_list.each do |node|
            print "#{node}   #{node.place_holder}"
            puts ""
        end
    end

end