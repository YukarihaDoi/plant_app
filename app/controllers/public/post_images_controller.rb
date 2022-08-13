class Public::PostImagesController < ApplicationController

  # 新規投稿
  def new
    @post_image = PostImage.new
  end

  # 投稿データの保存
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
     redirect_to post_images_path
    else
     render :new
    end
  end

  # 投稿一覧
  def index
    @post_images = PostImage.all
  end

  # 投稿詳細
  def show
    @post_image = PostImage.find(params[:id])
    @user = @post_image.user
    @comment = Comment.new
  end

  # 投稿編集
  def edit
    @post_image = PostImage.find(params[:id])
    if @post_image.user == current_user
      render :edit
    else
      redirect_to post_images_path
    end
  end

  # 投稿更新
  def update
    @post_image = PostImage.find(params[:id])
    if @post_image.update
     redirect_to post_images_path
    else
     render :edit
    end
  end

  # 投稿削除
  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :image, :body)
  end

end
