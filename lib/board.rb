# board class holds all the board nodes
class Board
    attr_reader :board
    def initialize
        @board = populate_board
    end

    # makes squares in board
    def populate_board
        board = []
        y = 0
        8.times do |row|
            x = 0
            if row % 2 == 1
                # black start
                8.times do |col|
                    if col % 2 == 1 
                        # black
                        board << Square.new((row*col), holder = nil, '⬜', [x,y])
                    else
                        # white
                        board << Square.new((row*col), holder = nil, '⬛', [x,y])
                    end
                    x += 1
                end
               
            elsif row % 2 == 0
                    # white start
                8.times do |col|
                    if col % 2 == 1 
                        # white
                        board << Square.new((row*col), holder = nil, '⬛', [x,y])
                    else
                        # black
                        board << Square.new((row*col), holder = nil, '⬜', [x,y])
                    end
                    x += 1
                end
               
            end
            y += 1    
        end
        return board
    end        

    def to_s
        puts ""
        print "  a    b    c    d    e    f    g    h"
        x = (0..9).to_a
        @board.each_with_index do |node, idx|
            
            puts "" if idx % 8 == 0
            
            puts "----------------------------------------" if idx % 8 == 0
            print x.shift if idx % 8 == 0
            print " "
            if node.piece_holder == nil
                print node.display
                print "  |"
            else
                print "#{node.piece_holder.place_holder} "
                print " |"
            end
            
        end
        puts 
    end

end

class Node
    def initialize(i)
        @value = i
    end
end 
# square (placement on the board graph)
class Square < Node
    attr_accessor :holder, :piece_holder
    attr_reader :display, :position
    def initialize(i, holder = nil, display, pos)
        @holder = holder
        @piece_holder = nil
        @display = display
        @position = pos
    end

end