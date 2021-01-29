module Mutations
  module Photos
    class AddUserPhoto < Mutations::BaseMutation
      argument :user_id, ID, required: true
      argument :user_photo, ApolloUploadServer::Upload, required: false

      type Types::PhotoType

      def resolve(params)
        blob = AddUserPhoto.upload_file(params[:user_photo])

        photo = Photo.create!(
          user_uploaded: true,
          user_photo: blob
        )

        UserPhoto.create!(photo_id: photo.id, user_id: params[:user_id])
        photo
      end

      private_methods

      def self.upload_file(file)
        ActiveStorage::Blob.create_and_upload!(
          io: file,
          filename: file.original_filename,
          content_type: file.content_type
        )
      end
    end
  end
end