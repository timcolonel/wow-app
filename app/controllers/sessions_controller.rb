class SessionsController < Devise::SessionsController
  wrap_parameters :user, include: [:email, :password], format: [:json]

  def new
    super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    if json_request?
      render json: {message: 'Signed in successfully!'}
    else
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end
end

