class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:update, :destroy]

  # GET /comments
  def index
    @comments = @post.comments.paginate(pagination_params).order(created_at: :desc)

    render json: {
      comments: serialized_object(@comments, {each_serializer: CommentSerializer}),
      meta: pagination_data(@comments)
    }
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params.merge(user: current_user, post: @post))

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = current_user.comments.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
