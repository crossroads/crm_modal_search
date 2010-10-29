@javascript
Feature: Filter and choose a record from a dedicated modal window
  In order to reduce duplication when selecting a record for a form,
  Users
  need to see more details and be confident that they are choosing the correct record.
  
  Scenario: User fills out the Opportunity create form and chooses an account via the modal window
    Given a logged in user
    
    And an account named "Crossroads International"
    And the account is tagged with "NGO"
    And an account named "FP Tuen Mun"
    And the account is tagged with "SWD"
    And an account named "NASA"
    And the account is tagged with "SWD"
    
    When I go to the opportunities page
    And I follow "Create Opportunity"
    And I fill in "opportunity[name]" with "Sell boat"
    And I fire the "mousedown" event on "account_id"
    Then I should see "Select Account"
    When I fill in "modal_query" with "Tuen"
    And I follow "FP Tuen Mun"
    
    And I press "Create Opportunity"
    Then I should see "Sell boat"
    Then I should see "FP Tuen Mun"
