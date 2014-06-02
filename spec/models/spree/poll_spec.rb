require 'spec_helper'

describe Spree::Poll do
  let(:poll) { create(:poll) }

  context "#create" do
    it "should create two default poll answers" do
      poll.poll_answers.count.should == 2 # yes & no
    end
  end

  context "#update" do
    it "should ensure at two default poll answers" do
      poll.update_attributes(name: 'zoo')
      poll.poll_answers.count.should >= 2 # at least yes & no
    end
  end

  context "#destroy" do
    it "should clean up the answers upon removal" do
      answers = poll.poll_answers
      poll.destroy
      answers.each do |answer|
        expect { answer.reload }.to raise_error
      end
    end
  end
end
