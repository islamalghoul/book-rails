class BooksController < ApplicationController
    before_action :set_book, only: %i[show edit update destroy]

    def index
      @books = Book.all
    end

    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      @book[:auther_id]=@book[:auther_id].to_i
      if @book.save
        redirect_to @book
      else
        render 'new'
      end
    end

    def edit
    end

    def update
      if @book.update(book_params)
        redirect_to @book
      else
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
  end
