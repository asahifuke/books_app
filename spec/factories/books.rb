# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'プロを目指す人のためのRuby入門 言語仕様からテスト駆動開発・デバッグ技法まで' }
    memo { 'Rubyの文法をサンプルコードで学び、例題でプログラミングの流れを体験できる解説書です。' }
    author { '伊藤 淳一' }
  end

  trait :with_attachment do
    picture { Rack::Test::UploadedFile.new(Rails.root.join('spec/files/attachment.jpg'), 'image/jpeg') }
  end
end
