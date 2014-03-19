module Spree
  class PollAnswer < ActiveRecord::Base
    belongs_to :poll
    has_many :poll_votes, dependent: :destroy
    has_one :image, as: :viewable, class_name: "Spree::Image"
    accepts_nested_attributes_for :image
    #validates :answer, presence: true
    before_destroy :ensure_enclosing_poll_still_has_at_least_two_answers

    def tally
      poll_votes.count
    end

    private
      def ensure_enclosing_poll_still_has_at_least_two_answers
        return false if poll.poll_answers.count <= 2 # the count does not yet reflect this deletion
      end
  end
end
