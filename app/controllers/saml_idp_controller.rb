class SamlIdpController < SamlIdp::IdpController

  def idp_authenticate(identity_key, password) # not using params intentionally
    user = User.find_by(identity_key: identity_key)
    return unless user.present?
    return unless user.valid_password?(password)

    user
  end
  private :idp_authenticate

  def idp_make_saml_response(user) # not using params intentionally
    encode_response user
  end
  private :idp_make_saml_response

  def idp_logout
    user = User.find_by(saml_request.name_id)
    user.logout
  end
  private :idp_logout
end

