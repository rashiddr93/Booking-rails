#
# SessionStore
#
# @author rashid
#
class SessionStore < ApplicationRecord
  belongs_to :user

  def self.create_session_for(user)
    session = SessionStore.create(
      session_key: session_key,
      session_expiry: nil,
      user_id: user.id
    )

    session.session_key
  end

  def self.session_key
    random_token = SecureRandom.urlsafe_base64(nil, false)
    if SessionStore.find_by(session_key: random_token).blank?
      return random_token
    end
    session_key
  end

  private

  def expired?
    if session_expiry.nil?
      false
    elsif session_expiry.present? && Time.zone.now.utc < session_expiry
      false
    else
      true
    end
  end
end
