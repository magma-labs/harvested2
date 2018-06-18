require 'spec_helper'

describe Harvest::User do
  it_behaves_like 'a json sanitizer', %w(cache_version)

  describe '#timezone' do
    it 'should convert friendly timezone setting' do
      p = Harvest::User.new(:timezone => :cst)
      expect(p.timezone).to eql('Central Time (US & Canada)')

      p = Harvest::User.new(:timezone => :est)
      expect(p.timezone).to eql('Eastern Time (US & Canada)')

      p = Harvest::User.new(:timezone => :mst)
      expect(p.timezone).to eql('Mountain Time (US & Canada)')

      p = Harvest::User.new(:timezone => :pst)
      expect(p.timezone).to eql('Pacific Time (US & Canada)')

      p = Harvest::User.new(:timezone => 'pst')
      expect(p.timezone).to eql('Pacific Time (US & Canada)')
    end

    it 'should convert standard zones' do
      p = Harvest::User.new(:timezone => 'america/chicago')
      expect(p.timezone).to eql('Central Time (US & Canada)')
    end

    it 'should leave literal zones' do
      p = Harvest::User.new(:timezone => 'Central Time (US & Canada)')
      expect(p.timezone).to eql('Central Time (US & Canada)')
    end
  end
end
