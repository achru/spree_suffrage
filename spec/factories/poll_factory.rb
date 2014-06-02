FactoryGirl.define do
  factory :poll, :class => Spree::Poll do
    sequence(:name) { |n| "Poll ##{n} - #{Kernel.rand(9999)}" }
    sequence(:question) { |n| "Question ##{n} - #{Kernel.rand(9999)}" }

    poll_answers do
      Array(2).sample.times.map do
        FactoryGirl.create(:poll_answer)
      end
    end
  end
end

FactoryGirl.define do
  factory :poll_answer, :class => Spree::PollAnswer do
    answer { Faker::Lorem.word }
  end
end

FactoryGirl.define do
  factory :poll_vote, :class => Spree::PollVote do
    ip_address { Array.new(4){rand(256)}.join('.') }
  end
end
