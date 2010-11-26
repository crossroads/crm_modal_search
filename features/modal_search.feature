@javascript
Feature: Filter and choose a record from a dedicated modal window
  In order to reduce duplication when selecting a record for a form,
  Users
  need to see more details and be confident that they are choosing the correct record.
  
  Scenario: User fills out the Opportunity create form and selects an account via the modal window
    Given a logged in user
    
    And an account named "Crossroads International"
    And the account is tagged with "NGO"
    And an account named "Tuen Mun Poker Club"
    And the account is tagged with "SWD"
    And an account named "NASA"
    And the account is tagged with "SWD"
    
    When I go to the opportunities page
    And I follow "Create Opportunity"
    And I fill in "opportunity[name]" with "Shipment to the Moon"
    And I follow "select" within "#account_id_modalbox"
    Then I should see "Select Account"
    When I fill in "modal_query" with "Tuen"
    Then I should see "Tuen Mun Poker Club"
    And I should see "0 contacts | 0 opportunities"
    
    When I fire the "click" event on css selector "#accounts li"[0]
    And I press "Create Opportunity"
    Then I should see "Shipment to the Moon from Tuen Mun Poker Club"
