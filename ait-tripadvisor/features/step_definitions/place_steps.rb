
Given(/^I am register user$/) do
  @user = FactoryGirl.create :ruser
end

Given(/^I want to add new place$/) do
  #visit '/service/places/new'
  visit '/'
  fill_in  'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Sign in'
  #save_and_open_page
end

When(/^I visit adding new place page$/) do
  visit '/service/places/new'
  #save_and_open_page
end

Then(/^I fill the entries for new place$/) do
  @place = FactoryGirl.create :nplace
  #@place = Place.new (name: 'Phi Phi', description: 'Near Bangkok')
  fill_in 'Name', with: @place.name
  fill_in 'Description', with: @place.description
  have_select '#place_category_id', options: ['cat1', 'cat2', 'cat3']
end

Then(/^I click on Create place$/) do
  click_button 'Create Place'
end

Then(/^I saw message that place have been created$/) do
  #save_and_open_page
  #expect(page).to have_content 'created'
end
