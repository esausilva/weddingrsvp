class Rsvp < ActiveRecord::Base
  attr_accessor :rsvp_code

  validates :party, presence: true, length: { minimum: 5 }
  validates :attendees, presence: true
  #validates :accept, presence: true
  #validates :comment, length: { minimum: 15 }
  validates :rsvp_code, presence: true
  validate :valid_code

  default_scope -> { order(party: :asc) }

  private

  def valid_code
    if rsvp_code != '1234'
      errors.add(:rsvp_code, 'does not match invitation code')
    end
  end
end