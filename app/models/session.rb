#
# Session
#
# @author rashid
#
class Session
  def self.create_session_for(user)
    SessionStore.create_session_for(user)
  end

  def initialize(request)
    @request = request
    @session = session
  end

  def session
    @session ||= find_session
  end

  def present?
    @session.present?
  end

  def expired?
    @session.expired?
  end

  def delete
    @session.delete if @session.present?
  end

  private

  def find_session
    session_key = @request.headers['HTTP_SESSION_KEY']
    if session_key.blank?
      raise Exceptions::RequiredHeaderMissingError.new(
        'SESSION_KEY'
      ), 'header is required'
    end
    SessionStore.find_by_session_key(session_key)
  end
end
