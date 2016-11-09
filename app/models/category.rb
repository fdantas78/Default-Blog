class Category < ActiveRecord::Base
    
    before_save { self.name.capitalize! }
    
    validates :name, presence: true, 
        uniqueness: { case_sensitive: false },
        length: {minimum: 3, maximum: 30}
    
end