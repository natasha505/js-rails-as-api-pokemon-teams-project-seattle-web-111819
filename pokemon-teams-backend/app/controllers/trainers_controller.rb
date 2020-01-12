class TrainersController < ApplicationController

  def index
    @trainers = Trainer.all 
    render :json => @trainers # when you got to your local server youre asking to send the data to /trainers
  end 

  def show
    @trainer = Trainer.find(params[:id])
    render :json => @trainer
  end 

  def edit
    @trainer = Trainer.find(params[:id])
    render :json => @trainer
  end 

  def update
    # byebug
    @trainer = Trainer.find(params[:id])
    @trainer.name = params[:name]
    @trainer.save
    render :json => @trainer 
    # byebug
  end 


end
