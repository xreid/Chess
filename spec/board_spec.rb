module Chess
  describe Board do
    subject { board }
    let(:board) { Board.new }
    it { is_expected.to be_a Board }
    it { puts subject }
  end
end
