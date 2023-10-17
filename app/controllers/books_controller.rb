
class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @filterrific = initialize_filterrific(
      Book,
      params[:filterrific],
      select_options: {
        by_auther_name: Auther.pluck(:name)
      }
    )

    @books = Book.all

    if params[:filterrific].present?
      if params[:filterrific][:by_auther_name].present?
        @books = @books.joins(:auther).where('authers.name LIKE ?', "%#{params[:filterrific][:by_auther_name]}%")
      end

      if params[:filterrific][:by_name].present?
        @books = @books.where("#{Book.table_name}.name LIKE ?", "%#{params[:filterrific][:by_name]}%")
      end

      if params[:filterrific][:search_query].present?
        @books = @books.where("#{Book.table_name}.release_date LIKE ?", "%#{params[:filterrific][:search_query]}%")
      end
    end

    @books = @books.paginate(page: params[:page], per_page: 10)
    puts @books.inspect
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @books.to_csv, filename: "filtered_books.csv" }


    end
  end




  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.auther = current_auther
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "Book was successfully updated."
      redirect_to @book
    else
      flash.now[:error] = "Failed to update the book."
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :release_date, :auther_id)
  end
  def export_csv
    @books = Book.all
    puts "helllllllllllllllllllllllllllllllllllllllllllllllo"

    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"books.csv\""
        headers['Content-Type'] = 'text/csv; charset=utf-8'
      end
    end
  end



end
