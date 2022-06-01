class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:edit, :update, :new, :create, :destroy]
   # before_action :check_if_admin, only: [:destroy]
    before_action :can_modify?, only: [:edit, :update, :destroy]

    def index
        @posts = Post.page(params[:page]).per(20)
    end 

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end

    def edit
        @post = Post.find(params[:id])
    end

    def create
        @post = Post.create(posts_params)
        @post.user = current_user
        respond_to do | format|
            if @post.save
                format.html { redirect_to post_path(@post), notice: "Se creo tu post"}
            else
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    def update
        @post = Post.find(params[:id])

        respond_to do | format|
            if @post.update(posts_params)
                format.html { redirect_to post_path(@post), notice: "Se creo tu post"}
            else
                format.html { render :edit, status: :unprocessable_entity }
            end
        end
        
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        respond_to do |format|
            format.html { redirect_to root_path, alert: "Tu post fue eliminado"}
        end
    end
    
    private


    def can_modify?
        post = Post.find(params[:id])
        if not (current_user.id == post.user_id || current_user.isadmin?)
            respond_to do |format|
                format.html { redirect_to root_path, alert: "No tienes acceso"}
            end
        end
    end

    def posts_params
        params.require(:post).permit(:title, :description, :image_url)
    end
end
