class PostsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  devise_token_auth_group :member, contains: [:user, :admin]
  before_action :authenticate_member!

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_post, except: [:index]

  # GET /posts
  def index
    authorize(Post)
    @posts = Post.all
    success_response(@posts, :ok)
  end

  # GET /posts/1
  def show
    authorize(@post ? @post : Post)
    if @post
      success_response(@post, :ok)
    else
      error_response([], :unprocessable_entity, "not found")
    end
  end

  # POST /posts
  def create
    @data = post_params
    @data[:admin_id] = current_member.id
    @post = Post.new(@data)
    authorize(@post ? @post : Post)

    if @post.save
      success_response(@post, :created)
    else
      error_response(@post.errors)
    end
  end

  # PATCH/PUT /posts/1
  def update
     authorize(@post ? @post : Post)
    if @post
      if @post.update(post_params)
        success_response(@post)
      else
        error_response(@post.errors)
      end
    else
      error_response(["message": "no data found"])
    end
  end

  # DELETE /posts/1
  def destroy
    authorize(@post ? @post : Post)
    if @post
      @post.destroy
      success_response(["success": "deleted success"])
    else
      success_response("not found resource")
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.exists?(params[:id]) ? Post.find(params[:id]) : nil
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.permit(:id, :title, :company_name, :description)
  end

  def pundit_user
    current_member
  end

end
