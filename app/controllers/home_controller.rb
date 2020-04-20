class HomeController < ApplicationController
  def index
    flash[:notice] = 'A new user was successfully created! Right on, man!'
    flash[:alert] = 'You do not have the rights to delete the entire database. And why would you even want to do that?'
  end
end
