module Spree
  class Poll < ActiveRecord::Base
#    attr_accessible :name, :question, :poll_answers_attributes, :allow_view_results_without_voting

    validates :name, uniqueness: true
    validates :name, :question, presence: true
    validates :poll_answers, length: { :minimum => 2}

    has_many :poll_answers, dependent: :destroy
    accepts_nested_attributes_for :poll_answers, allow_destroy: true

    def build_answer_with_image
      answer = poll_answers.build
      answer.build_image
      answer
    end

    class << self
      def current
        all.shuffle.first
      end
    end

    def has_results?
      poll_answers.inject(0) { |sum, answer|
        sum + answer.poll_votes.count
      } > 0
    end
  end
end
