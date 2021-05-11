class CommentsController < ApplicationController
  before_action :set_post, except: [:update, :destroy]
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
    if @comment.nil?
      render json: {error: "comment not found"}, status: :not_found
    elsif @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    if @comment.nil?
      render json: {error: "comment not found"}, status: :not_found
    else
      @comment.destroy
    end
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      post = Post.find(params[:post_id])
      @comment = current_user.comments.where(id: params[:id], post: post).first
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
