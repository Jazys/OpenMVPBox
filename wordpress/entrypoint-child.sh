#!/bin/bash
set -euo pipefail

if [ ! -f wp-config.php ]; then
    echo "WordPress not found in $PWD!"
    ( set -x; sleep 15 )
fi

if ! $(wp core is-installed --allow-root ); then

    echo "Adding permissions"
    wp --info
    
   echo "install site"
    wp core install --url=$WORDPRESS_URL --title="Mettre Le Titre" --admin_user=$WORDPRESS_USER --admin_password=$WORDPRESS_PWD --admin_email=$WORDPRESS_MAIL --skip-email --skip-plugins --allow-root
   
    sleep 10
    echo "update"
    wp core update --allow-root     
    sleep 10
    wp core update-db --allow-root 

    wp plugin delete akismet hello --allow-root   
  
    echo "language"
    wp language core install fr_FR --allow-root
    wp site switch-language fr_FR --allow-root

    
    echo "plugins"
    wp plugin install export-wp-page-to-static-html \
    wpgetapi \
    elementor \
    brizy \
    kadence-blocks \
    kadence-starter-templates \
    advanced-custom-fields \
    backwpup \
    all-in-one-seo-pack \
    code-snippets \
    code-snippets-extended --allow-root

    wp theme install kadence --allow-root

    wp plugin activate --all --allow-root
    
    echo "Permissions added"
fi

exec docker-entrypoint.sh "$@"
