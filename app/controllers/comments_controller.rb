class CommentsController < ApplicationController
  def create_comment
    post = Post.find(params['post_id'])
    comments = post.comments
    comment = post.build_comment 'body' => params['body'],
                                 'author' => params['author']

    if comment.save
      redirect_to "/show_post/#{params['post_id']}"
    else
      render "application/show_post", locals: { post: post, comment: comment, comments: comments }
    end
  end

  def list_comments
    comments = Comment.all

    render "application/list_comments", locals: { comments: comments }
  end

  def delete_comment
    post = Post.find params['post_id']
    post.delete_comment params['comment_id']
    redirect_to "/show_post/#{params['post_id']}"
  end
end
