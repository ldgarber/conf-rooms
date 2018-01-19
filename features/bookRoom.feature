Feature: Book a conference room
  Only logged in users can book a room
  A room can not be booked for a time when it's already booked

Scenario: When not logged in
  Given I am not logged in
  And I am on the home page
  When I try to book a room
  Then I see a message that I need to be signed in
  And I can log in
    
