module Spree
  class PollVote < ActiveRecord::Base
    belongs_to :user
    belongs_to :poll_answer
    delegate :poll, to: :poll_answer

    validates :poll_answer_id, :ip_address, presence: true
    validate :one_vote_per_person

    def self.with_user_or_ip(user_id, ip_address)
      if user_id.nil?
        where(ip_address: ip_address)
      else
        where(user_id: user_id)
      end
    end

  private
    def one_vote_per_person
      if PollVote.where(poll_answer_id: poll_answer_id).with_user_or_ip(user_id, ip_address).exists?
        errors.add(:base, "can't vote more than once")
      end
    end
  end
end
