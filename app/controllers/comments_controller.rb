class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def create
    @post = Post.find(params['post_id'])
    @comment = post.build_comment 'body' => params['body'],
                                 'author' => params['author']

    if @comment.save
      redirect_to post_path(@post.id)
    else
      render "posts/show"
    end
  end

  def destroy
    post = Post.find params['post_id']
    post.delete_comment params['comment_id']

    redirect_to post_path(post.id)
  end
end
