Given(/^I am about to login$/) do
  @page = @page.homePage
  @page = @page.login
end

When(/^I enter valid credentials$/) do
  user = CREDENTIALS[:valid_user]
  @page = @page.enter_credentials(user[:username],
                                  user[:password]
  )
end

Then(/^I can see my name in the page$/) do

end
