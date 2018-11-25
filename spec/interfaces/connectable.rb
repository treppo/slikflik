module ConnectableInterfaceTest
  it "responds to connect" do
    @subject.must_respond_to :connect
  end
end
