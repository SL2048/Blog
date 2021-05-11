class ReactionsController < ApplicationController
  before_action :set_reaction, only: [:destroy]
  before_action :set_comment, only: [:create]

  # POST /reactions
  def create
    @reaction = Reaction.new(reaction_params.merge(user: current_user, comment: @comment))

    if @reaction.save
      render json: @reaction, status: :created
    else
      render json: @reaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reactions/1
  def destroy
    unless @reaction.nil?
      @reaction.destroy
    else
      render json: {error: "reaction not found"}, status: :not_found
    end
  end

  private
    def set_comment
      post = Post.find(params[:post_id])
      @comment = post.comments.find(params[:comment_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_reaction
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:comment_id])
      @reaction = @comment.reactions.where(id: params[:id], user: current_user).first
    end

    # Only allow a trusted parameter "white list" through.
    def reaction_params
      params.require(:reaction).permit(:reaction_type)
    end
end
