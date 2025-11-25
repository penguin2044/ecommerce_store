# config/initializers/active_admin_patches.rb

module ActiveAdmin
  module Filters
    module ResourceExtension
      def default_association_filters
        if resource_class.respond_to?(:reflect_on_all_associations)
          associations = resource_class.reflect_on_all_associations

          # Filter out problematic associations
          associations.reject! do |r|
            # Skip has_many :through associations
            next true if r.is_a?(ActiveRecord::Reflection::ThroughReflection)

            # Skip Active Storage attachments
            next true if r.name.to_s =~ /(_attachments|_blobs|_attachment|_blob|images)$/

            # Skip polymorphic belongs_to
            next true if r.macro == :belongs_to && r.options[:polymorphic]

            false
          end

          associations.map(&:name)
        else
          []
        end
      end
    end
  end
end