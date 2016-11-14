class Category < ActiveRecord::Base
    
   has_many :article_categories, dependent: :destroy
   has_many :articles, through: :article_categories
   
   default_scope { order(name: :asc) }
   
   before_save { self.name.capitalize! }
    
    validates :name, presence: true, 
        uniqueness: { case_sensitive: false },
        length: {minimum: 3, maximum: 30}
        
end