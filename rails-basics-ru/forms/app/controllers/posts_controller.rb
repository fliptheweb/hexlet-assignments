class PostsController < ApplicationController
  def index
    @posts = Post.all.where(published: true).order(:created_at)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = 'New post has been successfully created'
      redirect_to post_path(@post)
    else
      flash[:failure] = 'Post hasn`t been created'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = 'Post has been successfully updated'
      redirect_to post_path(@post)
    else
      flash[:failure] = 'Post hasn`t been updated'
      render :edit, status: 422
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:success] = 'Post has been successfully deleted'
      redirect_to posts_path
    else
      flash[:failure] = 'Post hasn`t been deleted'
      redirect_to post_path(@post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :summary, :published)
  end
end
