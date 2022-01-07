class CommentsController < ApplicationController
  before_action :find_post, only: [:create, :destroy]

  def index
    @comments = Comment.all
  end

  def create
    @comment = post.comments.build(post_params)

    if @comment.save
      flash[:success] = "You have successfully created the comment."
      redirect_to post_path(@post)
    else
      @post.reload.comments
      flash.now[:error] = "Comment couldn't be created. Please check the errors."
      render "posts/show"
    end
  end

  def destroy
    @post.comments.delete params[:id]

    redirect_to post_path(@post.id)
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit( :body, :author)
  end
end
