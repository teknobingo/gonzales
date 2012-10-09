# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :outfit do
    style "Mexican"
    speedy :shoe, :boot
    speedy :hat, :sombrero
  end
end
