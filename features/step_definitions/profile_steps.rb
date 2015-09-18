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

Given(/^Unmodifiable information displayed is correct$/) do
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

When(/^I change the email and email confirmation$/) do
  @current.enter_email('prueba')
end

Then(/^The email will be changed in the user's profile$/) do
end
