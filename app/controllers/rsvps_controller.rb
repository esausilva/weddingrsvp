class RsvpsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create, :thankyou, :search]
  #before_action :set_rsvp, only: [:destroy]

  def index
    @rsvps = Rsvp.all
    @rsvps_paginate = @rsvps.paginate(page: params[:page], per_page: 15)
    @attendees_sum = @rsvps.where(accept: true).sum(:attendees)

    respond_to do |format|
      format.html
      format.csv { render text: @rsvps.to_csv }
    end
  end

  def new
    @rsvp = Rsvp.new
  end

  def create
    @rsvp = Rsvp.new(rsvp_params)

    if verify_recaptcha(model: @rsvp) && @rsvp.save
      flash[:success] = 'Thank you for taking the time to fill this RSVP!'
      redirect_to thankyou_rsvps_path
    else
      render 'new'
    end
  end

  def destroy
    Rsvp.find(params[:id]).destroy
    flash[:success] = 'RSVP was successfully deleted.'
    redirect_to rsvps_path
  end

  def thankyou
  end

  def search
    if params[:search].present?
      @rsvps = Rsvp.search params[:search], fields: [:party], page: params[:page], per_page: 15
      @rsvps_count = @rsvps.total_count
    else
      @rsvps = Rsvp.paginate(page: params[:page], per_page: 15)
    end
  end

  private

  def rsvp_params
    params.require(:rsvp).permit(:party, :attendees, :email, :comment, :accept, :rsvp_code)
  end

  #def set_rsvp
  #  @rsvp = Rsvp.find(params[:id])
  #end
end