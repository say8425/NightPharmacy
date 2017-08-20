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
    items = @portal.items(2)
    assert items.count.equal?(2), 'Controlling length of data is FAIL'

    items = @portal.items(42)
    assert items.count.equal?(42), 'Controlling length of data is FAIL'

    items = @portal.items(15)
    assert items.count.equal?(15), 'Controlling length of data is FAIL'
  end

  test 'Getting All of Data from the Portal' do
    all_info = @portal.total_item
    assert all_info.count.equal?(@portal.total_count), 'Getting all of data is FAIL'
  end
end
