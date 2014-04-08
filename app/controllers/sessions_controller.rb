class SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    self.resource = warden.authenticate(auth_options)
    if resource.nil?
      if params[:return_json]
        render :json => {:success => false}
      else
        redirect_to new_user_session_path, :alert => 'Wrong credentials'
      end
    else
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      clean_up_passwords resource
      if params[:return_json]
        render :json => {:success => true}
      else
        redirect_to root_path
      end
    end
  end
end

