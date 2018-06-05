shared_examples_for 'a json sanitizer' do |keys|
  keys.each do |key|
    it "doesn't include '#{key}' when serializing to json" do
      instance = described_class.new
      instance[key] = 10
      expect(instance.as_json.keys).not_to include(key)
    end
  end
end
