module Chess
  describe Board do
    subject { board }
    let(:squares) { board.squares }
    let(:board) { Board.new }
    let(:eli) { Player.new(:eli, :white) }
    let(:ada) { Player.new(:ada, :black) }
    it { is_expected.to be_a Board }
    it { puts subject }
    describe '#move' do
      context "when attempting to move the opponent's piece" do
        it 'raises a PieceOwnershipError' do
          expect { subject.move([1, 1], [2, 1], eli) }.to(
            raise_exception PieceOwnershipError)
        end
      end
      context 'when attempting to move an empty square' do
        it 'raises an EmptySquareError' do
          # [3, 2] is blank
          expect { subject.move([3, 1], [2, 1], eli) }.to(
            raise_exception EmptySquareError)
        end
      end
      context 'when attempting to move to a friendly square' do
        it 'raises a TeamKillError' do
          # [7, 3] is a King, [6, 3] is a pawn
          expect { subject.move([7, 3], [6, 3], eli) }.to(
            raise_exception TeamKillError)
        end
      end
      context 'when attempting to make an illegal move' do
        it 'raises an IllegalMoveError' do
          # [6, 0] is a Pawn
          expect { subject.move([6, 0], [5, 1], eli) }.to(
            raise_exception IllegalMoveError)
        end
      end
      context "when a piece's path is blocked"  do
        it 'raises a BlockedPathError' do
          # [0, 0] is a Rook, [1, 0] is a Pawn, [2, 0] is blank
          expect { subject.move([0, 0], [2, 0], ada) }.to(
            raise_exception BlockedPathError)
        end
      end
      it 'moves a black pawn forward' do
        expect(board.squares[1][0].contents).to be_a Pawn
        expect(board.squares[3][0].contents).to eq ' '
        board.move([1, 0], [3, 0], ada)
        expect(board.squares[1][0].contents).to eq ' '
        expect(board.squares[3][0].contents).to be_a Pawn
      end
      it 'moves a white pawn forward' do
        expect(board.squares[6][0].contents).to be_a Pawn
        expect(board.squares[4][0].contents).to eq ' '
        board.move([6, 0], [4, 0], eli)
        expect(board.squares[6][0].contents).to eq ' '
        expect(board.squares[4][0].contents).to be_a Pawn
      end
      it 'moves a black rook forward' do
        expect(board.squares[0][0].contents).to be_a Rook
        expect(board.squares[2][0].contents).to eq ' '
        board.move([1, 0], [3, 0], ada)
        board.move([0, 0], [2, 0], ada)
        expect(board.squares[0][0].contents).to eq ' '
        expect(board.squares[2][0].contents).to be_a Rook
      end
      it 'moves a white rook forward' do
        expect(board.squares[0][0].contents).to be_a Rook
        expect(board.squares[2][0].contents).to eq ' '
        board.move([6, 0], [4, 0], eli)
        board.move([7, 0], [5, 0], eli)
        expect(board.squares[7][0].contents).to eq ' '
        expect(board.squares[5][0].contents).to be_a Rook
      end
    end
    describe '#check_mate?' do
      subject { board.check_mate? }
      context 'when no king is check mated' do
        it { is_expected.to be_falsey }
      end
      context 'when the black king is check mated' do
        it do
          white_king = squares[7][3].contents
          board.move([6, 2], [4, 2], eli)
          board.move([1, 3], [2, 3], ada)
          board.move([6, 1], [4, 1], eli)
          board.move([0, 4], [4, 0], ada)
          p squares[7][3]
          is_expected.to eq white_king
        end
      end
    end
  end
end
