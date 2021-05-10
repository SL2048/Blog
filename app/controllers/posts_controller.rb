class PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]

  # GET /posts
  def index
    @posts = current_user.posts.paginate(pagination_params).order(updated_at: :desc)

    render json: {
      posts: serialized_object(@posts, {each_serializer: PostSerializer}),
      meta: pagination_data(@posts)
    }
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params.merge(user: current_user))

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  protected

  def pagination_params
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    {
      page: page,
      per_page: per_page
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_user.posts.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
