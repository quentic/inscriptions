# embarquer les assets pré-compilés dans l'image Nginx
reconstruire_image_docker: recompiler_les_assets;	docker-compose build
recompiler_les_assets: nettoyer_les_assets_precompiles ;	docker-compose run app rake assets:precompile RAILS_ENV=production
nettoyer_les_assets_precompiles: ; 	rm -Rf public/assets/*
