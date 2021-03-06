FactoryGirl.define do
  factory :majang do
    name '마장백화점약국'
    phone '02-962-1161'
    address '서울특별시 동대문구 고산자로 410, 1층 (용두동)'
    way '용두역 3번출구 200m'
    monday %w[0640 2330]
    tuesday %w[0640 2330]
    wednesday %w[0640 2330]
    thursday %w[0640 2330]
    friday %w[0640 2330]
    saturday %w[0640 2330]
    sunday %w[0800 2300]
    holiday %w[0640 2330]
    hpid 'C1101582'
    coordinates '(37.576294444444443, 127.038525000000007)'
  end
end
