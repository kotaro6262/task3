class BookComment < ApplicationRecord
 #空欄でコメント投稿できないように
 validates :comment, presence: true  
 
 belongs_to :user
  belongs_to :book
end
