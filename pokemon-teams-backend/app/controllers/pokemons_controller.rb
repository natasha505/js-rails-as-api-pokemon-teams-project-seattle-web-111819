require 'faker'

class PokemonsController < ApplicationController

  def index
    @pokemons = Pokemon.all
    render :json => @pokemons
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    render :json => @pokemon
  end

  #prod dont need
  def new
    @pokemon = Pokemon.new
  end

# when crt new pokemon gonna be a POST route, when it comes back id the trainer & send back the trainer.id with the create button.
  def create #may need to modify
    @trainer = Trainer.find(params[:trainer_id])  #### team.id
    # byebug
    if @trainer.pokemons.count >= 6 #check if team has more than 6 pokemon, if true do nothing. send an error msg saying you got  full team
      # flash[:message] =  "Your team is full. Remove a pokemon."
      NULL #need error handling
    else # if less than 6 do this: create these associations
      @pokemon = Pokemon.new(pokemon_params)
      @pokemon.nickname = Faker::Name.first_name
      @pokemon.species = Faker::Games::Pokemon.name
      @pokemon.trainer = @trainer
      @pokemon.save
      render :json => @trainer
    end
  end

  def destroy
    @pokemon = Pokemon.find(params[:id])
    @trainer = @pokemon.trainer 
    @pokemon.destroy
    render :json => @trainer
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:nickname, :species, :trainer_id, :pokemon => {})
  end

end