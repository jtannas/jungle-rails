require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
  # SETUP
  before :each do
    @user = User.create! name: 'Sir Tim Berners-Lee', email: 'tblee@inter.net', password: 'internet', password_confirmation: 'internet'
  end

  scenario "They sign in with the correct credentials and their username is displayed as signed in" do
    # ACT
    visit new_session_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_on('Submit')

    # DEBUG / VERIFY
    expect(find('.navbar .navbar-text')).to have_content('Signed in as ' + @user.name)
  end

  scenario "They sign in with incorrect credentials and a warning is displayed" do
    # ACT
    visit new_session_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: 'incorrect'
    click_on('Submit')

    # DEBUG / VERIFY
    expect(find('div.alert.alert-warning')).to have_content('Email or password is invalid')
  end
end
