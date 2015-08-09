module Chess
  describe Square do
    subject { Square.new }
    it { is_expected.to have_attributes(contents: ' ', threatened: false) }
  end
end
