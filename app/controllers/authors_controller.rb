class AuthorsController < ApplicationController
  before_action :set_author, only: %i[show edit update destroy]

  def index
    @filterrific = initialize_filterrific(
      Auther,
      params[:filterrific],
      select_options: {
      }
    )

    if params[:filterrific].present? && params[:filterrific][:by_name].present?
      @authors = Auther.where('name LIKE ?', "%#{params[:filterrific][:by_name]}%")
    else
      @authors = Auther.all
    end
  end

  def show
  end

  def set_author
    @author = Auther.find(params[:id])
  end
end
