FactoryGirl.define do
  factory :fabrick, :class => Material do
    name "Fabrick"
  end
  factory :leader, :class => Material do
    name "Leather"
  end
  factory :rubber, :class => Material do
    name "Rubber"
  end
end
