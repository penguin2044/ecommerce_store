# config/initializers/active_storage_ransack.rb

# Configure Ransack for Active Storage models
module ActiveStorage
  class Attachment < ActiveRecord::Base
    def self.ransackable_attributes(auth_object = nil)
      ["blob_id", "created_at", "id", "name", "record_id", "record_type"]
    end
  end

  class Blob < ActiveRecord::Base
    def self.ransackable_attributes(auth_object = nil)
      ["byte_size", "checksum", "content_type", "created_at", "filename", "id", "key", "metadata"]
    end
  end
end