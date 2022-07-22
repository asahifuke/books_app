# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it '題目、メモ、著者は有効です。' do
    book = FactoryBot.build(:book)
    expect(book).to be_valid
  end
end
