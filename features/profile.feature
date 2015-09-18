Feature: Personal profile
  As a user I want to check and modify my personal information.
  Background:
    Given I am logged-in

  Scenario: Unmodifiable data is displayed
    When I am at profile page
    Then Unmodifiable information displayed is correct

  Scenario: Modify user's email
    Given I am at user's profile page
    When I enter an invalid email
    Then The email won't show a data changes' message
