# Gestion des utilisateurs de l'application Offres Print
#
# Les fonctions "toggle" permettent d'activer les droits utilisateur par un clic sur la page users/index
class UsersController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  before_action :set_user, except: [:index]
  respond_to :html

  # GET /users
  # GET /users.xml
  # Affichage des utilisateurs de l'application Offres Print
  def index
    @page_title = "gestion des utilisateurs"
    @users = User.order(:email).all
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    flash[:error] = "Cet utilisateur n'a pas pu être détruit" if !@user.destroy

    respond_with(@user)
  end


  # Positionne les droits de gestionnaire de campagne DSCM
  def toggle_campagne_manager
    @user.toggle!(:campagne_manager)
    render :nothing => true
  end

private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :nom, :prenom)
  end

end
