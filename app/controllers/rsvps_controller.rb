class RsvpsController < ApplicationController
  before_action :set_rsvp, only: [:show, :destroy]

  def index
    @rsvps = Rsvp.all
  end

  def new
    @rsvp = Rsvp.new
  end

  def create
    @rsvp = Rsvp.new(rsvp_params)

    validCode = params['rsvp_code'] == '1234' ? true : false

    if validCode and @rsvp.save
      flash[:success] = 'Thank you'
      redirect_to root_path
    else
      if !validCode
        @rsvp.errors.add(:rsvp, 'Your invitation code does''t match')
      end

      render 'new'
    end
  end

  private

  def rsvp_params
    params.require(:rsvp).permit(:party, :attendees, :comment, :accept)
  end

  def set_rsvp
    @rsvp = Rsvp.find(params[:id])
  end
end