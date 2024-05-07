class ListsController < ApplicationController
  def new
     @list = List.new
  end

  def create
    @list = List.new(list_params) # １.&2. データを受け取り新規登録するためのインスタンス作成
    if @list.save # 3. データをデータベースに保存するためのsaveメソッド実行
      flash[:notice] = "投稿に成功しました。"
      redirect_to list_path(@list.id) # 4. show画面へリダイレクト
    else
      flash.now[:alert] = "投稿に失敗しました。"
      redirect_to new_list_path
    end
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to '/lists'
  end

   private
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end

#private 一種の境界線で、「ここから下はこのcontrollerの中でしか呼び出せません」という意味
#params formから送られてくるデータはparamsの中に入っています。
#require 送られてきたデータの中からモデル名(ここでは:list)を指定し、データを絞り込みます。
#permit requireで絞り込んだデータの中から、保存を許可するカラムを指定します。