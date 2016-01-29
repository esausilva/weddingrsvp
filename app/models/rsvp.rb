class Rsvp < ActiveRecord::Base
  attr_accessor :rsvp_code

  searchkick

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :party, presence: true, length: { minimum: 5 }
  validates :attendees, presence: true
  #validates :accept, presence: true
  validates :comment, length: { minimum: 5 }, allow_blank: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :rsvp_code, presence: true
  validate :valid_code

  default_scope -> { order('lower(party) asc') }

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |attendee|
        csv << attendee.attributes.values_at(*column_names)
      end
    end
  end

  private

  def valid_code
    if rsvp_code != ENV['RSVP_CODE']
      errors.add(:rsvp_code, 'does not match invitation code')
    end
  end
end
