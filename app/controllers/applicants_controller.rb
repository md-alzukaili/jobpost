class ApplicantsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  devise_token_auth_group :member, contains: [:user, :admin]
  before_action :authenticate_member!

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_applicant, except: [:index]

  # GET /applicants
  def index
    authorize(Applicant)
    @applicants = Applicant.all
    success_response(@applicants)
  end

  # GET /applicants/1
  def show
    authorize(@applicant ? @applicant : Applicant)
    if @applicant
      success_response(@applicant, :ok)
    else
      error_response([], :unprocessable_entity, "not found")
    end
  end

  # POST /applicants
  def create
    data = applicant_params
    data['is_seen'] = 0;
    data['user_id'] = current_user.id;
    @applicant = Applicant.new(data)

    authorize(@applicant ? @applicant : Applicant)

    if @applicant.save
      success_response(@applicant, :created)
    else
      error_response(@applicant.errors)
    end

  end

  # PATCH/PUT /applicants/1
  def update
    authorize(@applicant ? @applicant : Applicant)
    if @applicant.update(applicant_params)
      success_response(@applicant)
    else
      error_response(@applicant.errors)
    end

  end

  # DELETE /applicants/1
  def destroy
    authorize(@applicant ? @applicant : Applicant)
    if @applicant
      @applicant.destroy
      success_response(["success": "deleted success"])
    else
      error_response("not found resource")
    end
  end

  def seen
    if @applicant
      authorize(@applicant ? @applicant : Applicant)
      @applicant.is_seen = true
      @applicant.save
      success_response("seen success")
    else
      error_response("not found resource")
    end
  end

  private

  def set_applicant
    @applicant = Applicant.exists?(params[:id]) ? Applicant.find(params[:id]) : nil
  end

  def applicant_params
    params.permit(:id, :user_id, :post_id, :is_seen, :attachment_url)
  end

  def pundit_user
    current_member
  end

end
