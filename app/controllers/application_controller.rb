# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_action :authenticate
  before_action :set_page, only: [:index, :update, :destroy]
  before_action :set_filtre, only: [:index, :update, :destroy, :rechercher]
  #helper :all # include all helpers, all the time

protected

   def authenticate
     authenticate_or_request_with_http_basic("Veuillez saisir les codes d'accès fournis par Aline lors de la réunion. Si vous ne les avez plus, contactez Aline au : 06 30 60 48 28") do |username, password|
       username == "raid2018" && password == "raid2018"
     end
   end

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'c5e28f3b6733d33bf00c0e51f6f70ff8'

	# Positionnement de la langue préférée de l'utilisateur via un cookie (bascule en cliquant sur le drapeau de langue)
	def langue
		cookies[:langue] = (cookies[:langue] == "french" ? "english" : "french")
		redirect_to :back
	end

  # Pour les résultats paginés, récupère le numéro de la page courante (ou se positionne en page 1 par défaut)
  def set_page
    @page = params[:page] || 1
  end

  # Pour les pages avec moteur de recherche, récupère le terme recherché
  def set_filtre
    @filtre = params[:filtre]
  end

end
