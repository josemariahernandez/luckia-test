Feature: Initial experience
  As a user I want a helpful and simple initial
  experience with the app. I should be able to get 
  login to Luckia site.

  Scenario: Valid login
    Given I am about to login
    When I enter valid credentials
    Then I can see my name in the page

  Scenario:Invalid login
    Given I am about to login
    When I enter invalid credentials
    Then The app will show a error message