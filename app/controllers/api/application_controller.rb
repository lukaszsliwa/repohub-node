class Api::ApplicationController < ActionController::Base
  include ActionController::Serialization

  before_filter :current_user
  before_action :doorkeeper_authorize!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique,  with: :record_invalid
  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from 'ActiveResource::ResourceInvalid', with: :record_invalid

  def current_resource_owner
    User.find doorkeeper_token.resource_owner_id if doorkeeper_token
  end

  def current_user
    current_resource_owner
  end

  def admin_only
    render json: { errors: ['You are not allowed to do this operation.'] }, status: :forbidden unless current_user.admin?
  end

  def record_invalid(exception)
    render json: exception_to_json(exception), status: :unprocessable_entity
  end

  def record_not_found(exception)
    render json: exception_to_json(exception), status: :not_found
  end

  def server_error(exception)
    render json: exception_to_json(exception), status: :server_error
  end

  def unmatched_route
    render json: { message: 'Route not found', request: request.fullpath, errors: { route: ['not found'] } }
  end

  def exception_to_json(exception)
    errors = exception.respond_to?(:record) ? { errors: exception.record.errors.messages } : { errors: [] }
    { message: exception.message, request: request.fullpath }.merge(errors)
  end
end
