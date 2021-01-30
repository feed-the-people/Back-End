module Types
  class PhotoType < Types::BaseObject
    include Rails.application.routes.url_helpers

    field :id, ID, null: false
    field :user_photo_url, String, null: true

    def user_photo_url
      Cloudinary::Utils.cloudinary_url(object.user_photo.blob.key) if object.user_photo.attached?
    end
  end
end