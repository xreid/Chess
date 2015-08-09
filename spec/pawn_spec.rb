module Chess
  describe Pawn do
    subject { pawn }
    let(:pawn) { Pawn.new(:black, [0, 0]) }
    it { is_expected.to be_a ChessPiece }
    it { is_expected.to be_a Pawn }
    it do
      is_expected.to have_attributes(
        color: :black, position: [0, 0], first_move: true
      )
    end
    describe '#moves' do
      it 'returns all possible moves' do
        expect(subject.moves).to eq [[1, 0], [2, 0], [1, 1]]
        subject.position = [4, 4]
        expect(subject.moves).to eq [[5, 4], [6, 4], [5, 3], [5, 5]]
      end
    end
  end
end
