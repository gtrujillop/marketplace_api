class NotLoggedInError < StandardError
  def initialize(msg="Unauthorized.")
    super
  end
end
