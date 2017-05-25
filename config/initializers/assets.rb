# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(
maaf/campagnes.js
maaf/elements.js  maaf/elements.css
maaf/offres.js
maaf/client_centre_couts.js
maaf/livraison_points.js
maaf/demandeurs.js

porsche/campagnes.js
porsche/elements.js  porsche/elements.css
porsche/offres.js
porsche/livraison_points.js
porsche/demandeurs.js

commodites.js
demandes_et_commandes.css demandes_et_commandes_impr.css
fournisseurs.js
home.css
users.js

tablesaw.css  tablesaw.js
jquery.jeditable.mini.js
)
