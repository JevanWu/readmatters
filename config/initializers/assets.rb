# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
#
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(
                                                  devise_layout.css products/*
                                                  pages/*
                                                  books/*
                                                  orders/*
                                                  bootstrap-tagsinput/dist/bootstrap-tagsinput.css
                                                  bootstrap-tagsinput/dist/bootstrap-tagsinput.min
                                                  typeahead.js/dist/typeahead.bundle.min.js
                                                  china_city/jquery.china_city.js
                                                )
