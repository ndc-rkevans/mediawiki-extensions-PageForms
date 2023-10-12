ARG MW_VERSION=1.35
FROM gesinn/docker-mediawiki-sqlite:${MW_VERSION}

ARG SMW_VERSION=4.0.1
RUN COMPOSER=composer.local.json composer require --no-update mediawiki/semantic-media-wiki ${SMW_VERSION} && \
    curl -L https://github.com/wikimedia/mediawiki-extensions-PageSchemas/tarball/0.6.1 | tar xz --strip-components 1 --one-top-level=extensions/PageSchemas && \
    curl -L https://github.com/wikimedia/mediawiki-extensions-DisplayTitle/tarball/3.1 | tar xz --strip-components 1 --one-top-level=extensions/DisplayTitle && \
    sudo -u www-data composer update && \
    php maintenance/update.php --skip-external-dependencies --quick

ENV EXTENSION=PageForms
COPY composer*.json package*.json /var/www/html/extensions/$EXTENSION/

RUN cd extensions/$EXTENSION && \
    npm ci && \
    composer update

COPY . /var/www/html/extensions/$EXTENSION

RUN sed -i s/80/8080/g /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf && \
    echo \
        'wfLoadExtension( "SemanticMediaWiki" );\n' \
        'enableSemantics( $wgServer );\n' \
        'wfLoadExtension( "PageSchemas" );\n' \
        'wfLoadExtension( "DisplayTitle" );\n' \
        "wfLoadExtension( '$EXTENSION' );\n" \
    >> LocalSettings.php && \
	php maintenance/update.php --quick
