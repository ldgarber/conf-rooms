Given(/^I am not logged in$/)do 
  page.driver.delete('/users/sign_out') #make sure you are logged out  
end

And(/^I am on the home page$/)do 
  visit '/'
end

When(/^I try to book a room$/)do 
  visit '/meetings/new'
end

Then(/^I see a message that I need to be signed in$/)do
  expect(page).to have_content("You need to sign in or sign up before continuing.")
end

And(/^I can log in$/)do
  expect(page).to have_selector("input[value='Log in']")
end

