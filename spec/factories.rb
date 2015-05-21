FactoryGirl.define do
  factory :event do
    what 'My Event'
    description 'My Description'
    where 'Over Here'
    price 80
    status 'open'
    ticket false
    booked false
    deadline 2.days.from_now
    limited false
    sequence(:when, 3) { |n| (n * 3).days.from_now }
    trait :booked do
      booked true
    end
    trait :open do
      status 'open'
    end
    trait :closed do
      status 'closed'
    end
    factory :confirmed_event, traits: [:closed, :booked]
  end

  factory :user do
    name 'My Name'
    trait :logged_in do
      guest_user false
    end
    trait :guest_user do
      guest_user true
    end
  end

  factory :invite do
    event { create :event }
    guest { create :user }
  end
end
