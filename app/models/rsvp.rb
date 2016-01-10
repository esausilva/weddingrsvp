class Rsvp < ActiveRecord::Base
  validates :party, presence: true, length: { minimum: 5 }
  validates :attendees, presence: true
  #validates :accept, presence: true
  validates :comment, length: { minimum: 15 }
end