# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :outfit do
    style "Mexican"
    speedy :shoe, :boot
    speedy :hat, :sombrero
    alternative_hats { |outfit| [outfit.association(:stetson)]  }
  end
  factory :girl_outfit, :class => Outfit do
    style "Mexican"
    speedy :shoe
    speedy :hat
    speedy :alternative_hats, :sombrero
  end
end
