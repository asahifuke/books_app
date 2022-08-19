# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'test title' }
    memo { 'test memo' }
    author { 'test auther' }
  end

  trait :with_attachment do
    picture { Rack::Test::UploadedFile.new(Rails.root.join('spec/files/attachment.jpg'), 'image/jpeg') }
  end
end
