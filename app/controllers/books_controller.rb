class BooksController < ApplicationController
  # GET /books
  # GET /books.json
  def index
    render locals: {
      books: filtered_sorted_paginated_results(params),
      starts_with_tags: first_characters_in_results(filtered_results(params)),
      campaign_name: name_of_filtering_campaign,
      filter_params: filter_params(params)
    }
  end

  # GET /books/1
  # GET /books/1.json
  def show
    render locals: { book: set_book }
  end

  # GET /books/new
  def new
    render locals: { book: Book.new }
  end

  # GET /books/1/edit
  def edit
    render locals: { book: set_book }
  end

  # POST /books
  # POST /books.json
  def create
    book = Book.new(book_params)

    respond_to do |format|
      if book.save
        format.html { redirect_to book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: book }
      else
        format.html { render :new, locals: { book: book } }
        format.json { render json: book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    book = set_book
    respond_to do |format|
      if book.update(book_params)
        format.html { redirect_to book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: book }
      else
        format.html { render :edit, locals: {book: book} }
        format.json { render json: book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    set_book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def filtered_sorted_paginated_results(params)
    filtered_sorted_results(params).page( params[:page] )
  end

  def set_book
    Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :abbreviation)
  end

  def filtered_sorted_results(params)
    filtered_results(params).order(view_context.sort_param(Book, params[:sort], params[:direction]))
  end

  def filtered_results(params)
    Book.filter(filter_params(params))
  end

  def filter_params(params)
    params.slice(:starting_with)
  end
end
