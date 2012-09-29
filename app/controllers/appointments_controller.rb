class AppointmentsController < ApplicationController
  def show
    #respond_to do |format|
      #format.html
    #end
  end
  def schedule
    @vets = User.all.select { |user| %w(vet technician).include?(user.role) }

  end
end
