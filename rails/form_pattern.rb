class PostsController < ApplicationController
    def create
        @post = Post.new(post_params)

        if @post.save
            render json: @post
        else
            render json: @post.error, status :unprocessable_entity
        end
    end

    private

    def post_params
        params
            .require(:post)
            .permit(:email, :author, :content, :timestamp)
        end
    end

class Post < ActiveRecord::Base
    EMAIL_REGEX = /@/

    validates :author, presence: true
    validates :email, presence: true, format: EMAIL_REGEX
    validates :content, presence: true
    validates :timestamp, presence: true
end


# In the above piece of code, the Post model contains the validation logic inside of it. 
# If you want to create another model called “Comment,” you would have to rewrite the same logic again. 
# Here’s how you can isolate the logic from the model using the form design pattern:

class PostForm
    EMAIL_REGEX = /@/

    include ActiveModel::Model
    include Virtus.model

    attribute :id, Integer
    attribute :author, String
    attribute :email, String
    attribute :content, String
    attribute :timestamp, String

    validates :author, presence: true
    validates :email, presence: true, format: EMAIL_REGEX
    validates :content, presence: true
    validates :timestamp, presence: true

    attr_reader :record

    def persist
        @record = id ? Post.find(id) : Post.new

        if valid?
            @record.attributes = attributes.except(:id)
            @record.save!
            true
        else
            false
        end
    end
end


# Once the logic has been written in PostForm, you can use it inside a Controller like this:

class PostsController < ApplicationController
    def create
        @post = UserPost.new(post_params)
    
        if @post.persist
            render json: @post.record
        else
            render json: @form.errors, status: :unprocessable_entity
        end
    end

    private

    def post_params
        params
            .require(:post)
            .permit(:author, :email, :content, :timestamp)
    end
end





