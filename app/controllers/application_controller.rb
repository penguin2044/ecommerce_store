class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :set_flash_hash

  private

  # Create a unique session hash for flash message verification
  def set_flash_hash
    session[:flash_hash] ||= Digest::SHA256.hexdigest("#{Time.current.to_i}-#{SecureRandom.hex}")
  end

  # Custom flash method that includes session hash
  def set_secure_flash(type, message)
    flash[type] = {
      message: message,
      hash: session[:flash_hash],
      timestamp: Time.current.to_i
    }
  end
end
