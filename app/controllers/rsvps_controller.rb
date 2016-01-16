class RsvpsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_rsvp, only: [:destroy]

  def index
    @rsvps = Rsvp.all
    @rsvps_paginate = @rsvps.paginate(page: params[:page], per_page: 15)
    @attendees_sum = @rsvps.where(accept: true).sum(:attendees)
  end

  def new
    @rsvp = Rsvp.new
  end

  def create
    @rsvp = Rsvp.new(rsvp_params)

    if verify_recaptcha(model: @rsvp) && @rsvp.save
      flash[:success] = 'Thank you'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def rsvp_params
    params.require(:rsvp).permit(:party, :attendees, :email, :comment, :accept, :rsvp_code)
  end

  def set_rsvp
    @rsvp = Rsvp.find(params[:id])
  end
end