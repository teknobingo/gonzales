FactoryGirl.define do
  factory :hat do
    brim_type "Fat"
    size 52
  end
  factory :sombrero, :class => 'Hat' do
    brim_type "Narrow"
    size 52
  end
  factory :stetson, :class => 'Hat' do
    brim_type "Cool"
    size 52
  end  
end
