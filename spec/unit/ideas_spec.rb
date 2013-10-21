require 'spec_helper'
require 'ideas'

describe Ideas do

  subject { Ideas }

  it { subject.must_respond_to :find }
end
