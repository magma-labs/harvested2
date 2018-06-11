require 'spec_helper'

describe Harvest::TaskAssignment do
  it_behaves_like 'a json sanitizer', %w(cache_version)
end
