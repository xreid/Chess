module Chess
  describe Player do
    subject { Player.new(:jon, :white) }
    it { is_expected.to have_attributes(name: :jon, color: :white) }
  end
end
