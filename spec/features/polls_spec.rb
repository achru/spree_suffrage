require 'spec_helper'
require 'support/shared_contexts/check_voting_allowed'

describe "Polls" do
  include_context "check_voting_allowed"

  before(:all) do
    Spree::User.destroy_all

    Deface::Override.new(name: 'add_poll_to_home_page',
                         virtual_path: 'spree/shared/_sidebar',
                         insert_top: '#sidebar',
                         partial: 'spree/polls/poll')
  end

  before(:each) do
    Spree::User.destroy_all
    Spree::Poll.destroy_all

    @poll = create(:poll, :allow_view_results_without_voting => false)
    @user = create(:user)
    visit spree.root_path
  end

  let!(:product) do
    product = create(:product)
    product.taxons << create(:taxon)
  end

  context "user has not voted in this poll" do
    context "as a logged in user", js: true do
      before { sign_in_as! @user }
      it "should allow me to vote" do
        check_voting_allowed
      end
    end

    context "as an anonymous user" do
      it "should allow me to vote", js: true do
        check_voting_allowed
      end
    end

    context "viewing results is allowed for poll" do
      before { @poll.update_attributes(allow_view_results_without_voting: true) }

      describe "hasn't been voted yet" do
        before { visit spree.root_path }

        it "should not show the 'view results' link" do
          page.should_not have_link(I18n.t(:view_poll_results))
        end
      end

      describe "someone has voted" do
        let!(:poll_vote_1) { create(:poll_vote, poll_answer: @poll.poll_answers.first) }
        before { visit spree.root_path }

        it "should allow me to see the results" do
          click_link I18n.t(:view_poll_results)
          page.should have_selector("#poll_results_list")
        end
      end
    end

    context "viewing results is not allowed" do
      it "should allow me to see the results" do
        page.should_not have_link(I18n.t(:view_poll_results))
      end
    end
  end

  context "already voted in this poll" do
    context "logged in user" do
      it "should show me the poll results", js: true do
        sign_in_as! @user
        vote!
        page.should have_selector("#poll_results_list")
      end
    end
    context "anonymous user" do
      it "should show me the poll results", js: true do # no idea why this won't work w/out js: true
        page.find("input[type=radio]").click

        click_button I18n.t(:vote)

        visit spree.root_path

        page.should have_selector("#poll_results_list")
      end
    end
  end
end
