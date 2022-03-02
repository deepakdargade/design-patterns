# Here is how you can define a Policy class:

class PostPolicy
    def initialize(post)
       @post = post
    end

    private
    attr_reader :post

    def hasEmail?
        post.email?
    end

    def hasAuthor?
        post.author?
    end
end


# The above policy implements checks for email and author. You can use it in the following way:

class PostHandler
    def uploadPost(post)
    # method to upload a post to database
        policy = PostPolicy.new(post)

        if (policy.hasEmail && policy.hasAuthor)
            # save to database here
        else
            puts "error occurred"
        end
    end
end
