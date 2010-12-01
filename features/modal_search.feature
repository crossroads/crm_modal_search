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
    Then I should see "Tuen Mun Poker Club" within "#modal_search"
    And I should see "0 contacts | 0 opportunities"
    When I fire the "click" event on css selector "#accounts li"[0]
    Then I should see "Tuen Mun Poker Club" within "#account_id_modalbox"
    
    When I follow "select" within "#account_id_modalbox"
    Then I should see "Select Account"
    When I fill in "modal_query" with "NAS"
    Then I should see "NASA" within "#modal_search"
    When I fire the "click" event on css selector "#accounts li"[0]
    Then I should see "NASA" within "#account_id_modalbox"
    
    And I press "Create Opportunity"
    Then I should see "Shipment to the Moon from NASA"
    
  Scenario: Opportunity create form fails validation, then saves properly with required fields
    Given a logged in user
    
    And an account named "Crossroads International"
    And the account is tagged with "NGO"
    And an account named "Tuen Mun Poker Club"
    And the account is tagged with "SWD"
    And an account named "NASA"
    And the account is tagged with "SWD"
    
    When I go to the opportunities page
    And I follow "Create Opportunity"
    And I follow "select" within "#account_id_modalbox"
    Then I should see "Select Account"
    When I fill in "modal_query" with "Tuen"
    Then I should see "Tuen Mun Poker Club" within "#modal_search"
    When I fire the "click" event on css selector "#accounts li"[0]
    Then I should see "Tuen Mun Poker Club" within "#account_id_modalbox"
    
    When I press "Create Opportunity"
    Then I should see "Please specify opportunity name"
    And I should see "select" within "#account_id_modalbox"
    And I should see "Tuen Mun Poker Club" within "#account_id_modalbox"
       
    When I fill in "opportunity[name]" with "Shipment to the Moon"
    When I press "Create Opportunity"
    
    Then I should see "Shipment to the Moon from Tuen Mun Poker Club"
    
    
  Scenario: User edits an existing Opportunity to select a new account
    Given a logged in user
    And an account named "Tuen Mun Poker Club"
    And the account is tagged with "NGO"
    And an opportunity named "Local Order #12345" from "Crossroads International"
    When I go to the opportunities page
    And I move the mouse over "opportunity_1"
    And I follow "Edit" within "#opportunity_1"
    And I follow "select" within "#account_id_modalbox"
    Then I should see "Select Account"
    When I fill in "modal_query" with "Tuen"
    Then I should see "Tuen Mun Poker Club" within "#modal_search"
    When I fire the "click" event on css selector "#accounts li"[0]
    
    And I press "Save Opportunity"
    Then I should see "Local Order #12345 from Tuen Mun Poker Club"
