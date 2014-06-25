require 'spec_helper'

describe Spree::PollAnswer do
  let(:poll) { create(:poll) }

  context "#destroy" do
    it "should disallow removal if we'd go underneath the minimum answers criteria of the enclosing poll" do
      answer = poll.poll_answers.last
      answer.destroy
      expect {answer.reload}.to_not raise_error # record is still there b/c validation failed
    end
  end

  describe '#vote_list_name' do
    let(:poll_answer) { poll.poll_answers.first }

    describe 'with no image and answer' do
      it 'responds with the answer.name' do
        expect(poll_answer.vote_list_name).to eq(poll_answer.answer)
      end

      describe 'with no image and no answer' do
        let(:empty_answer) do
          poll_answer.answer = ''
          poll_answer.image = nil
          poll_answer.save!
          poll_answer
        end

        it 'responds with empty answer' do
          expect(empty_answer.vote_list_name).to eq('empty answer')
        end
      end
    end
  end
end
