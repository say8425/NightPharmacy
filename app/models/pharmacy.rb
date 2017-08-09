class Pharmacy < ApplicationRecord
  validates_uniqueness_of :hpid
end
