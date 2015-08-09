module Chess
  describe Knight do
    subject { knight }
    let(:knight) { Knight.new(:black, [0, 0]) }
    it { is_expected.to be_a ChessPiece }
    it { is_expected.to be_a Knight }
    it { is_expected.to have_attributes(color: :black, position: [0, 0]) }
    describe '#moves' do
      it 'returns all posible moves' do
        expect(subject.moves).to eq [[1, 2], [2, 1]]
        subject.position = [4, 4]
        expect(subject.moves).to eq [
          [3, 2], [5, 2], [2, 3], [2, 5], [3, 6], [5, 6], [6, 5], [6, 3]
        ]
      end
    end
    describe '#to_s' do
      subject { knight.to_s }
      context 'when black' do
        it  { is_expected.to eq '♞' }
      end
      context 'when white' do
        it  { knight.color = :white; is_expected.to eq '♘' }
      end
    end
  end
end
