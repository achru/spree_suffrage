require 'spec_helper'

describe "Polls" do
  before(:all) do
    Spree::Poll.destroy_all
    Spree::User.destroy_all

    @admin = create(:admin_user)
  end
  let(:admin) { @admin }

  context "as admin user" do
    before(:each) do
      visit spree.admin_path
      sign_in_as! admin
      visit '/admin/polls'
    end

    context "listing polls" do
      context "sorting" do
        before { Spree::Poll.destroy_all }

        let(:poll_1) { create(:poll, name: 'astarted') }
        let(:poll_2) { create(:poll, name: 'bstarted') }
        let!(:sorted_polls) { [poll_1.name, poll_2.name] }

        it "should list existing polls with correct sorting by name" do
          click_link "Polls"

          # Name ASC
          within_row(1) { page.should have_content(sorted_polls.first) }
          within_row(2) { page.should have_content(sorted_polls.second) }

          # Name DESC
          click_link "admin_polls_listing_name_title"
          within_row(1) { page.should have_content(sorted_polls.second)  }
          within_row(2) { page.should have_content(sorted_polls.first) }
        end
      end

      context 'delete a poll' do
        let!(:poll) { create(:poll) }
        before { click_link "Polls" }

        it 'should list the created poll before deletion' do
          page.should have_content(poll.name)
        end

        it 'should allow you to delete', js: true do
          page.find("#spree_poll_#{poll.id} .delete-resource").click

          page.should have_content("successfully removed!")
          expect(Spree::Poll.last).not_to eq poll
        end
      end

      context 'view the results of a poll' do
        let!(:poll) { create(:poll) }

        it 'should allow you to view the result', js: true do
          click_link "Polls"
          find("#listing_polls #spree_poll_#{poll.id} a").click
          page.should have_css("#listing_poll_answers")
        end
      end

    end

    context "creating a new poll" do
      before do
        click_link "Polls"
        click_link "admin_new_poll"
      end

      it "should allow an admin to create a new poll", js: true do
        within('#new_poll') do
          page.should have_content("QUESTION")
        end

        fill_in "poll_name", :with => "Are you ugly"
        fill_in "poll_question", :with => "Are you ugly?"
        click_button "Create"
        page.should have_content("successfully created!")
      end

      it "should show validation errors" do
        click_button "Create"
        page.should have_content("Name can't be blank")
      end
    end

    context 'updating a poll' do
      let(:poll) { create(:poll) }

      before do
        visit spree.admin_poll_path(poll)
      end

      it 'should allow you to update' do
        fill_in "poll_question", :with => "are you a good person?"
        click_button "Update"
        page.should have_content("successfully updated!")
        Spree::Poll.last.question.should == 'are you a good person?'
      end

      context "configuring answers" do
        it 'should allow you to add an answer', js: true do
          visit spree.admin_poll_path(poll)
          click_link "Add Answer"
          find("#new_poll_answers input[type=text]").set("green")
        end

        it 'should allow you to remove an answer' do
          visit spree.admin_poll_path(poll)
          click_button "Update"
        end
        it 'should allow you to edit an answer' do
          visit spree.admin_poll_path(poll)
          click_button "Update"
        end
      end
    end
  end
end
