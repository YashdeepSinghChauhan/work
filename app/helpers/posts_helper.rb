module PostsHelper
    def render_with_hashtags(description)
        description.gsub(/#\w+/){|word| link_to word, "/posts/hashtag/#{word.downcase.delete('#')}"}.html_safe
    end
   def code
  		self.description.split('/').last if self.description
	end
end
