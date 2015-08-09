module Chess
  describe King do
    subject { king }
    let(:king) { King.new(:black, [0, 0]) }
    it { is_expected.to be_a ChessPiece }
    it { is_expected.to be_a King }
    it { is_expected.to have_attributes(color: :black, position: [0, 0]) }
    describe '#moves' do
      it 'returns all possible moves' do
        expect(subject.moves).to eq [[0, 1], [1, 1], [1, 0]]
        subject.position = [4, 4]
        expect(subject.moves).to eq [
          [4, 3], [3, 3], [3, 4], [3, 5],
          [4, 5], [5, 5], [5, 4], [5, 3]
        ]
      end
    end
  end
end
