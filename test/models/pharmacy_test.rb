require 'test_helper'

class PharmacyTest < ActiveSupport::TestCase
  setup do
    @info = PharmacyPortal.new
  end

  test 'Connect Data go portal' do
    info = @info.connect_gov
    assert info.success?, 'Accessing Data portal is FAIL!'
  end

  test 'Controlling Data length' do
    info = @info.infos(2)
    assert info.count.equal?(2), 'Controlling length of data is FAIL'

    info = @info.infos(42)
    assert info.count.equal?(42), 'Controlling length of data is FAIL'

    info = @info.infos(15)
    assert info.count.equal?(15), 'Controlling length of data is FAIL'
  end
end
