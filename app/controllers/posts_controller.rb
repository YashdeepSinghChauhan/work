class PostsController < ApplicationController
before_action :set_categories, only: [:new, :create, :edit]
before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote]
before_action :authenticate_user!, except: [:browse, :show]
impressionist :actions=>[:show]
respond_to :js, :coffeescript
    
    def browse
        if params[:category].blank?
           @posts = Post.all
        else
            @category_id = Category.find_by(name: params[:category]).id        
            @posts = Post.where(:category_id => @category_id).order("created_at DESC")
        end
    end

    def index
        if params[:category].blank?
           @posts = Post.where(user_id: current_user.all_following.pluck(:id))
        else
            @category_id = Category.find_by(name: params[:category]).id
            @posts = Post.where(:category_id => @category_id).order("created_at DESC")
        end
    end
    
 
    
    def show
        impressionist(@post)
        @comment = Comment.new  
        @comments = @post.comments.order("created_at DESC")
        @user_posts = @post.user
        
    end
    
    def new
        @post = current_user.posts.build
    end
    def notify(user)
        Notification.create do |notification|
        notification.notify_type = 'mention'
        notification.actor = @post.user
        notification.user = user
        notification.target = @post
        notification.second_target = @post
    end
        
    end
    def create
        @post = current_user.posts.build(post_params)
        @post.category_id = params[:category_id]
        if @post.save
            if @post.mentioned_users.any?
                @post.mentioned_users.each do |mention|
                    notify(mention)
                end
            end
            redirect_to @post, notice: "Sucessfully Saved new post!"
        else
            render 'new'
        end
    end
    
    def edit
        
    end
    
    def update
        @post.category_id = params[:category_id]
        if @post.update(post_params)
            if @post.mentioned_users.any?
                @post.mentioned_users.each do |mention|
                    notify(mention)
                end
            end
            redirect_to @post, notice: "Post was successfully Updated!"
        else
            render 'edit'
        end
            
    end
    
    def hashtags
       @tag = Tag.find_by(name: params[:name])
       @posts = @tag.posts.all
    end
    
    def destroy
        @post.destroy
        redirect_to root_path
    end
    
    def upvote
        @post.upvote_by current_user
        redirect_to :post
    end
    
    
    
    private
    def find_post
        @post = Post.friendly.find(params[:id])
    end
    def post_params
        params.require(:post).permit(:title, :description, :category_id, images: [])
    end
    def set_categories
        @categories = Category.all.map{ |c| [c.name, c.id]}
    end
end
