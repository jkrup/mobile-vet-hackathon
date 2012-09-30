class PetsController < ApplicationController
  def new
    @pet= Pet.new
  end
  
  def index
    if current_user #here until real authentication is used
      @pets = Pet.where(client_id: current_user.id)
    else
      @pets.all
    end
  end
  
  def create
    if current_user
      @pet = Pet.create(params[:pet])
      @pet.client_id = current_user.id 
      @pet.save
      redirect_to new_pet_path, notice: "#{@pet.name} registered"
    else
      redirect_to "/"
    end
  end
  
end