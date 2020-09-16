require './lib/game.rb'

describe Game do
    it "converts player input into valid co_ord to use" do
        game = Game.new
        expect(game.convert_co_ord(['a','0'])).to eql([0,0])
        expect(game.convert_co_ord(['A','0'])).to eql(false)
    end

    it "finds chess piece given correct co_ord" do
        game = Game.new
        co_ord = game.convert_co_ord(['a','0'])
        expect(game.object_selector(co_ord)).to be_kind_of(ChessPiece)
    end

    it "returns false if selecting empty square" do
        game = Game.new
        co_ord = game.convert_co_ord(['a','2'])
        expect(game.object_selector(co_ord)).to eql(false)
    end
    

    it "returns false if selecting another player piece" do
        game = Game.new
        co_ord = game.convert_co_ord(['a','6'])
        expect(game.object_selector(co_ord)).to eql(false)
    end
end
