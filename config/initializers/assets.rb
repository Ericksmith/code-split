# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( 
  codemirror/lib/codemirror.js 
  codemirror/lib/codemirror.css 
  codemirror/theme/cobalt.css 
  codemirror/mode/javascript/javascript.js 
  codemirror/mode/fortran/fortran.js 
  codemirror/mode/go/go.js 
  codemirror/mode/haskell/haskell.js 
  codemirror/mode/php/php.js 
  codemirror/mode/python/python.js 
  codemirror/mode/ruby/ruby.js 
  codemirror/mode/swift/swift.js 
   )
