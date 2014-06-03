def sign_in_as!(user)
  visit '/login'
  fill_in 'Email', :with => user.email
  fill_in 'Password', :with => 'secret'
  click_button 'Login'
end

def vote!
  page.find("#new_poll_list input[type=radio]").click
  page.find("#new_poll_vote_container input[type=submit]").click
end
