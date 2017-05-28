require 'test_helper'

class PharmacyTest < ActiveSupport::TestCase
  setup do
    @single = PharmacyPortal.new
  end

  test 'Connect Data go portal' do
    get_infos = @single.infos
    assert get_infos.success?, 'Accessing Data portal is FAIL!'
  end
end
