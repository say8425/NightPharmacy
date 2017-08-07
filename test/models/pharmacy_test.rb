require 'test_helper'

class PharmacyTest < ActiveSupport::TestCase
  setup do
    @portal = PharmacyPortal.new
  end

  test 'Connecting the Data Portal' do
    info = @portal.connect_portal
    assert info.success?, 'Connecting the Data portal is FAIL!'
  end

  test 'Controlling a Data length' do
    infos = @portal.infos(2)
    assert infos.count.equal?(2), 'Controlling length of data is FAIL'

    infos = @portal.infos(42)
    assert infos.count.equal?(42), 'Controlling length of data is FAIL'

    infos = @portal.infos(15)
    assert infos.count.equal?(15), 'Controlling length of data is FAIL'
  end

  test 'Getting All of Data from the Portal' do
    all_info = @portal.all_infos
    assert all_info.count.equal?(@portal.total_count), 'Getting all of data is FAIL'
  end
end
