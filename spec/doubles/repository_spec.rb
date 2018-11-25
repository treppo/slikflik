require "spec_helper"
require "doubles/repository"
require "interfaces/repository"

describe RepositoryDouble do
  include RepositoryInterfaceTest

  before do
    @subject = RepositoryDouble.new
  end
end
