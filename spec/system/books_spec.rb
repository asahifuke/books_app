# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :system do
  let!(:book) { FactoryBot.create(:book, :with_attachment) }

  it '一覧画面のテスト' do
    visit books_path
    expect(page).to have_content book.title
  end

  it '新規作成のテスト' do
    title = 'create title test'
    memo = 'create memo test'
    author = 'create author test'

    visit books_path
    click_link 'New Book'
    input(title, memo, author, 'Create Book', 'Book was successfully created.')
  end

  it '編集のテスト' do
    title = 'update title test'
    memo = 'update memo test'
    author = 'update author test'
    visit books_path
    click_link 'Edit', match: :first
    input(title, memo, author, 'Update Book', 'Book was successfully updated.')
  end

  it '削除のテスト' do
    visit books_path
    expect(page).to have_content book.title
    page.accept_confirm do
      click_link 'Destroy', match: :first
    end
    expect(page).not_to have_content 'Book was successfully destroy.'
    expect(page).not_to have_content book.title
  end

  def input(title, memo, author, button, message)
    fill_in 'Title', with: title
    fill_in 'Memo', with: memo
    fill_in 'Author', with: author
    attach_file 'Picture', Rails.root.join('spec/files/attachment.jpg')
    click_button button
    expect(page).to have_content message
    expect(page).to have_content title
    expect(page).to have_content memo
    expect(page).to have_content author
    expect(page).to have_selector("img[src$='attachment.jpg']")
  end
end
