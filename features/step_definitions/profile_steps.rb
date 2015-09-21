Given(/^I am logged\-in$/) do
  @current = @page.homePage
  @current.goToLoginPage
  @current = @page.loginPage
  user = CREDENTIALS[:valid_user]
  @current.enter_credentials(user[:username],
                             user[:password])
  @current = @page.userHomePage
end

Given(/^I am at profile page$/) do
  @current.openProfileMenu
  @current = @page.profileMenuPage
  @current.goToProfile
  @current = @page.profilePage
end

Given(/^unmodifiable information displayed is correct$/) do
  expected_unmodifiable_information = @current.expectedUnmodifiableInformation
  current_unmodifiable_information = @current.currentUnmodifiableInformation

  fail "trololo" unless expected_unmodifiable_information==current_unmodifiable_information
end

Given(/^I am at user's profile page$/) do
  @current.openProfileMenu
  @current = @page.profileMenuPage
  @current.goToProfile
  @current = @page.profilePage
end

When(/^I enter an invalid email$/) do
  email = DATA[:invalid_data]
  #email = @current.openData('modifiable_information')
  @current.enter_email(email[:email])
end

Then(/^the email will be changed in the user's profile$/) do
  @current.no_exists_message?
end
