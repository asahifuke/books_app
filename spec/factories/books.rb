# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "title#{n}" }
    sequence(:memo) { |n| "memo#{n}" }
    sequence(:author) { |n| "auther#{n}" }
  end

  trait :with_attachment do
    picture { Rack::Test::UploadedFile.new(Rails.root.join('spec/files/attachment.jpg'), 'image/jpeg') }
  end
end
