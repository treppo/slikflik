module RepositoryInterfaceTest

  it 'responds to find' do
    @subject.must_respond_to :find
  end

  it 'responds to create' do
    @subject.must_respond_to :create
  end

  it 'responds to connect' do
    @subject.must_respond_to :connect
  end
end
