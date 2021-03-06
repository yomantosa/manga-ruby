class Post < ApplicationRecord

    has_many :authorships
    has_many :users, through: :authorships


    validates :title, presence: true
    validates :content, presence: true
    
    # validate :image_type
    validates :images, attached: true, content_type: %i[png jpg jpeg]

    has_many_attached :images

    def thumbnail input
        return self.images[input]
    end

end
