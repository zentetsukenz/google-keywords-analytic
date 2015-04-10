module AuthenticationHelper
  def AuthenticationHelper.issue_token(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def AuthenticationHelper.valid?(token)
    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base)
    rescue
      false
    end
  end
end
