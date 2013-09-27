class CommentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    @issue = Issue.find(params[:issue_id])
    @comment = @issue.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = 'Successfully created comment.'
      redirect_to @issue
    else
      redirect_to @issue
    end
  end

  # Edit
  def edit
  end

  def update
    if @comment.update_attributes(params[:issue])
      flash[:notice] = 'Successfully updated comment.'
      redirect_to @issue
    else
      render 'edit'
    end
  end

  # Delete
  def destroy
    @comment.destroy
    flash[:notice] = 'Successfully destroyed comment.'
    redirect_to @issue
  end

  ## Helper methods
  def comment_params
    params.require(:comment).permit(:body, :issue_id)
  end

end
