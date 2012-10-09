FactoryGirl.define do
  factory :shoe do
    name 'Classy'
    speedy :upper_material, :leader
    speedy :lower_material, :rubber
    speedy :inner_material, :leader
    size 42
  end
  factory :boot, :class => 'Shoe' do
    name 'Boot'
    speedy :upper_material, :leader
    speedy :lower_material, :leader
    speedy :inner_material, :leader
    size 42
  end
end
