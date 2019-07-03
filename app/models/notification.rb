# Auto generate with notifications gem.
class Notification < ActiveRecord::Base
    belongs_to :post, dependent: :destroy
    belongs_to :user, dependent: :destroy
    belongs_to :comment, dependent: :destroy

  include Notifications::Model

   # Write your custom methods...
end
