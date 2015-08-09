module Chess
  describe Bishop do
    subject { bishop }
    let(:bishop) { Bishop.new(:black, [0, 0]) }
    it { is_expected.to be_a ChessPiece }
    it { is_expected.to be_a Bishop }
    it { is_expected.to have_attributes(color: :black, position: [0, 0]) }
    describe '#moves' do
      it 'returns all possible moves' do
        expect(subject.moves).to eq [
          [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]
        ]
        subject.position = [4, 4]
        expect(subject.moves).to eq [
          [5, 3], [6, 2], [7, 1],
          [3, 3], [2, 2], [1, 1], [0, 0],
          [3, 5], [2, 6], [1, 7],
          [5, 5], [6, 6], [7, 7]
        ]
      end
    end
    describe '#to_s' do
      subject { bishop.to_s }
      context 'when black' do
        it  { is_expected.to eq '♝' }
      end
      context 'when white' do
        it  { bishop.color = :white; is_expected.to eq '♗' }
      end
    end
  end
end
