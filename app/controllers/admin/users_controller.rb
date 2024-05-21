class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin!

    def index
        @users = User.where.not(confirmed_at: nil)
                    .includes(:role).where(roles: { role_name: 'user' })
        render json: serialize_users(@users), status: :ok
    end
    
    def moderators
        @moderators = User.where.not(confirmed_at: nil)
                            .includes(:role)
                            .where(roles: { role_name: 'moderator' })
        render json: serialize_users(@moderators), status: :ok
    end
    
    def pending_users
        @users = User.where(confirmed_at: nil)
                    .includes(:role)
                    .where(roles: { role_name: ['user', 'moderator'] })
        render json: serialize_users(@users), status: :ok
    end

    def edit
        @user = User.find_by(id: params[:id])
        if @user
            render json: serialized_user(@user), status: :ok
        else
            render json: {
                status: { code: 404, message: 'The user could not be found.' }
            }, status: :not_found
        end
    end

    def update
        @user = User.find_by(id: params[:id])
        if @user
            if @user.update(user_params)
                render json: {
                    status: { code: 200, message: 'The user has been updated successfully!' },
                    data: serialized_user(@user)
                }, status: :ok
            else
                render json: {
                    status: { code: 422, message: 'Something went wrong with the user update.', errors: @user.errors.full_messages }
                }, status: :unprocessable_entity
            end
        else
            render json: {
                status: { code: 404, message: 'The user could not be found.' }
            }, status: :not_found
        end
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :role_id)
    end

    def ensure_admin!
        render json: {
            status: { code: 403, message: "You don't have permission to access this page." }
        }, status: :forbidden unless current_user.admin?
    end

    def serialize_users(users)
        users.map { |user| serialized_user(user) }
    end

    def serialized_user(user)
        UserSerializer.new(user).serializable_hash[:data][:attributes]
    end
end
