Feature: place
  Being a  register user i want to add new place to Ait-Tripadvisor


  Scenario: Add new place
    Only register user can add new place..
    Given  I am register user
    And  I want to add new place
    When  I visit adding new place page
    Then  I fill the entries for new place
    And I click on Create place
    Then I saw message that place have been created