class BooksController < ApplicationController
before_action :authenticate_user!
  def show
  	@book = Book.find(params[:id])
  end

  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    # 変更箇所11
    @book = Book.new
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
  	@book.user_id = current_user.id
    if @book.save #入力されたデータをdbに保存する。
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

# 変更箇所17
  def destroy
  	@book = Book.find(params[:id])
    # 変更箇所18
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
    # 変更箇所19
  	params.require(:book).permit(:title,:body)
  end

end
