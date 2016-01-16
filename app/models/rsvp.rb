class Rsvp < ActiveRecord::Base
  attr_accessor :rsvp_code

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :party, presence: true, length: { minimum: 5 }
  validates :attendees, presence: true
  #validates :accept, presence: true
  validates :comment, length: { minimum: 15 }, allow_blank: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :rsvp_code, presence: true
  validate :valid_code

  default_scope -> { order(party: :asc) }

  private

  def valid_code
    if rsvp_code != '1234'  #TODO: Change to environment variable
      errors.add(:rsvp_code, 'does not match invitation code')
    end
  end
end