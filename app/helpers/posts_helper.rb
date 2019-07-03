module PostsHelper
    def render_with_hashtags(description)
       description.gsub /@([\w]+)/ do |match|
            link_to match, user_path($1)
        end.html_safe
        description.gsub(/#\w+/){|word| link_to word, "/posts/hashtag/#{word.downcase.delete('#')}"}.html_safe
      
    end
    def code
  		self.description.split('/').last if self.description
    end

  
end
