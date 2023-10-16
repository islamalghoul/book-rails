class AuthorsController < ApplicationController
  before_action :set_author, only: %i[show edit update destroy]
  def index
    @authors = Auther.all
  end

  def show
  end
  def set_author
    @author = Auther.find(params[:id])
  end
end
