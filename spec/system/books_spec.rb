# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :system do
  let!(:book) { FactoryBot.create(:book, :with_attachment) }

  it '一覧画面のテスト' do
    visit books_path
    expect(page).to have_content 'プロを目指す人のためのRuby入門 言語仕様からテスト駆動開発・デバッグ技法まで'
  end

  it '新規作成のテスト' do
    visit books_path
    click_link 'New Book'
    fill_in 'Title', with: '新しいLinuxの教科書'
    fill_in 'Memo', with: '入門書'
    fill_in 'Author', with: '三宅 英明'
    attach_file 'Picture', Rails.root.join('spec/files/attachment.jpg')
    click_button 'Create Book'
    expect(page).to have_content 'Book was successfully created.'
    expect(page).to have_content '新しいLinuxの教科書'
    expect(page).to have_content '入門書'
    expect(page).to have_content '三宅 英明'
    expect(page).to have_selector "img[src$='attachment.jpg']"
  end

  it '編集のテスト' do
    visit books_path
    click_link 'Edit', match: :first
    fill_in 'Title', with: 'Everyday Rails - RSpecによるRailsテスト入門'
    fill_in 'Memo', with: 'RSpecを使ってRailsアプリケーションに信頼性の高いテストを書く実践的なアドバイスを提供します。'
    fill_in 'Author', with: 'Aaron Sumner and Junichi Ito'
    attach_file 'Picture', Rails.root.join('spec/files/attachment.jpg')
    click_button 'Update Book'
    expect(page).to have_content 'Book was successfully updated.'
    expect(page).to have_content 'Everyday Rails - RSpecによるRailsテスト入門'
    expect(page).to have_content 'RSpecを使ってRailsアプリケーションに信頼性の高いテストを書く実践的なアドバイスを提供します。'
    expect(page).to have_content 'Aaron Sumner and Junichi Ito'
    expect(page).to have_selector "img[src$='attachment.jpg']"
  end

  it '削除のテスト' do
    visit books_path
    expect(page).to have_content 'プロを目指す人のためのRuby入門 言語仕様からテスト駆動開発・デバッグ技法まで'
    page.accept_confirm do
      click_link 'Destroy', match: :first
    end
    expect(page).to have_content 'Book was successfully destroyed.'
    expect(page).not_to have_content 'プロを目指す人のためのRuby入門 言語仕様からテスト駆動開発・デバッグ技法まで'
  end
end
