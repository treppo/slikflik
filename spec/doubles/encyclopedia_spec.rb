require "doubles/encyclopedia"
require "interfaces/encyclopedia"

describe EncyclopediaDouble do
  include EncyclopediaInterfaceTest

  before do
    @subject = EncyclopediaDouble.new
  end
end
