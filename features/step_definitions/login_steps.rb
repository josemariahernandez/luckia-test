Given(/^I am about to login$/) do
  @current = @page.homePage
  @current.goToLoginPage
  @current = @page.loginPage
end

When(/^I enter valid credentials$/) do
  user = CREDENTIALS[:valid_user]
  @current.enter_credentials(user[:username],
                             user[:password]
  )
  @current = @page.userHomePage
end

Then(/^I can see my name in the page$/) do
  @current.pageExists?
end

When(/^I enter invalid credentials$/) do
  user = CREDENTIALS[:invalid_user]
  @current.enter_credentials(user[:username],
                             user[:password]
  )
end

Then(/^The app will show a error_message$/) do
  @current.error_message_exists?
end