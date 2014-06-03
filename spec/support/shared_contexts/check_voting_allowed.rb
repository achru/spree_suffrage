require 'support/helper_methods'

shared_context "check_voting_allowed" do
  def check_voting_allowed
   page.should have_selector("#new_poll_list")
   vote!
   page.should have_content(I18n.t(:thanks_for_voting))
   page.should have_selector("#poll_results_list")
  end
end
