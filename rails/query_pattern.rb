class PopularPostsQuery
    def call(relation)
      relation
        .where(type: :post)
        .where('view_count > ?', 100)
    end
  end
  
  class PostsController < ApplicationController
    def index
      relation = Post.accessible_by(current_ability)
      @popular_posts = PopularPostsQuery.new.call(relation)
    end
  end
  