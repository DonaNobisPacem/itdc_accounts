class SessionsController < Devise::SessionsController
  def destroy
    current_user.create_activity :sign_out, owner: current_user, ip_address: current_user.current_sign_in_ip
    super
  end
end
