Feature: Initial experience
  As a user I want a helpful and simple initial
  experience with the app. I should be able to get help
  and login to an existing WordPress site.

  Scenario: Login
    Given I am about to login
    When I enter valid credentials
    Then I can see my name in the page