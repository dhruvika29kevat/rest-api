class Api::V1::UsersController < ApplicationController
    def index
        @users = User.all
        render json: @users, adpter: :json
    end

    def show
        @user = User.find(params[:id])
        render json: @user
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user
        else
            render error: {error: 'Unable to create user!!!!'}, status: 400
        end
    end

    def update
        @user = User.find(params[:id])
        if @user
            @user.update(user_params)
            render json: {message: 'User updated successfully!!'}, status: 200
        else 
            render json: {error: 'Unable to update User!!!'}, status: 400
        end
    end

    def destroy
        @user = User.find(params[:id])
        if @user
            @user.destroy
            render json: {messgae: 'User deleted successfully.'}, status: 200
        else
            render json: {eroor: 'Unable to delete User!!'}, status: 400
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
