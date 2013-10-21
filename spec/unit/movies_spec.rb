require 'spec_helper'
require 'movies'

describe Movies do

  subject { Movies }

  it { subject.must_respond_to :connect }
end
