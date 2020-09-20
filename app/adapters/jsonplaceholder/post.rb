module Jsonplaceholder
  class Post
    include HTTParty

    base_uri 'jsonplaceholder.typicode.com'

    def initialize; end


    def find(post_id)
      response = self.class.get("/posts/#{post_id}")
      post = JSON.parse(response.body)
      post['count_comments'] = add_hash_count_comments(post)

      post
    end

    def add_hash_count_comments(object)
      if object.is_a?(Array)
        recipent.each do |post|
          post['count_comments'] = count_comments(post['id'])
        end
      else
        object['count_comments'] = count_comments(object['id'])
      end
    end
    
    def count_comments(post_id)
      response = self.class.get("/posts/#{post_id}/comments")
      count = JSON.parse(response.body).count
      count
    end
  end
end