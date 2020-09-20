module Jsonplaceholder
  class Post < Base

    def initialize; end

    def all(start = 0, limit = 10)
      response = self.class.get("/posts")
      posts = JSON.parse(response.body)
      add_hash_count_comments(posts)
    end


    def find(post_id)
      response = self.class.get("/posts/#{post_id}")
      post = JSON.parse(response.body)
      post['count_comments'] = add_hash_count_comments(post)

      post
    end

    def trending(limit = 5)
      sort_by_desc(all, 'count_comments')[0..limit].map do |post|
        {
          id: post['id'],
          title: post['title'],
          body: post['body'],
          count_comments: post['count_comments']
        }
      end
    end

    private

    def add_hash_count_comments(object)
      if object.is_a?(Array)
        object.each do |post|
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