# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :system do
  let!(:book) { FactoryBot.create(:book, :with_attachment) }

  it '一覧画面のテスト' do
    visit books_path
    expect(page).to have_content 'test title'
  end

  it '新規作成のテスト' do
    visit books_path
    click_link 'New Book'
    fill_in 'Title', with: 'create title test'
    fill_in 'Memo', with: 'create memo test'
    fill_in 'Author', with: 'create author test'
    attach_file 'Picture', Rails.root.join('spec/files/attachment.jpg')
    click_button 'Create Book'
    expect(page).to have_content 'Book was successfully created.'
    expect(page).to have_content 'create title test'
    expect(page).to have_content 'create memo test'
    expect(page).to have_content 'create author test'
    expect(page).to have_selector("img[src$='attachment.jpg']")
  end

  it '編集のテスト' do
    visit books_path
    click_link 'Edit', match: :first
    fill_in 'Title', with: 'update title test'
    fill_in 'Memo', with: 'update memo test'
    fill_in 'Author', with: 'update author test'
    attach_file 'Picture', Rails.root.join('spec/files/attachment.jpg')
    click_button 'Update Book'
    expect(page).to have_content 'Book was successfully updated.'
    expect(page).to have_content 'update title test'
    expect(page).to have_content 'update memo test'
    expect(page).to have_content 'update author test'
    expect(page).to have_selector("img[src$='attachment.jpg']")
  end

  it '削除のテスト' do
    visit books_path
    expect(page).to have_content 'test title'
    page.accept_confirm do
      click_link 'Destroy', match: :first
    end
    expect(page).not_to have_content 'Book was successfully destroy.'
    expect(page).not_to have_content 'test title'
  end
end
