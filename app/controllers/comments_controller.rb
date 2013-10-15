class CommentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    @issue = Issue.find(params[:issue_id])
    @comment = @issue.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = 'Successfully created comment.'
      @comment.create_activity :create, owner: current_user, project_id:@comment.issue.project.id
      redirect_to @issue
    else
      redirect_to @issue
    end
  end

  # Edit
  def edit
  end

  def update
    if @comment.update_attributes(params[:comment])
      flash[:notice] = 'Successfully updated comment.'
      redirect_to @comment.issue
    else
      render 'edit'
    end
  end

  # Delete
  def destroy
    @issue = Issue.find(params[:issue_id])
    @comment.destroy
    flash[:notice] = 'Successfully destroyed comment.'
    redirect_to issue_path(@issue)
  end

  ## Helper methods
  def comment_params
    params.require(:comment).permit(:body, :issue_id)
  end

end
