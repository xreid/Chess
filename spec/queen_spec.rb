module Chess
  describe Queen do
    subject { queen }
    let(:queen) { Queen.new(:black, [0, 0]) }
    it { is_expected.to be_a ChessPiece }
    it { is_expected.to be_a Queen }
    it { is_expected.to have_attributes(color: :black, position: [0, 0]) }

    describe '#move' do
      it 'returns all possible moves' do
        expect(subject.moves).to eq [
          [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
          [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
          [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]
        ]
        subject.position = [4, 4]
        expect(subject.moves).to eq [
          [4, 3], [4, 2], [4, 1], [4, 0],
          [3, 4], [2, 4], [1, 4], [0, 4],
          [4, 5], [4, 6], [4, 7],
          [5, 4], [6, 4], [7, 4],
          [5, 3], [6, 2], [7, 1],
          [3, 3], [2, 2], [1, 1], [0, 0],
          [3, 5], [2, 6], [1, 7],
          [5, 5], [6, 6], [7, 7]
        ]
      end
    end
    describe '#to_s' do
      subject { queen.to_s }
      context 'when black' do
        it  { is_expected.to eq '♛' }
      end
      context 'when white' do
        it  { queen.color = :white; is_expected.to eq '♕' }
      end
    end
  end
end
