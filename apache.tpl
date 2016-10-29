<VirtualHost *:8080>
        ServerName %domain
        ServerAlias www.%domain

        ServerAdmin webmaster@%domain
        DocumentRoot /var/www/vhosts/%domain/htdocs

        SuexecUserGroup %user %group

        <Directory /var/www/vhosts/%domain/htdocs/>
                DirectoryIndex index.php
                Options +ExecCGI +FollowSymLinks -Indexes
                AllowOverride All
                Require all granted
                AddHandler fcgid-script .php
                FCGIWrapper /var/www/vhosts/%domain/fcgi-bin/php-fcgi-starter
        </Directory>

	<IfModule remoteip_module>
                RemoteIPHeader X-Forwarded-For
                RemoteIPTrustedProxy 127.0.0.1
        </IfModule>

        ErrorLog /var/www/vhosts/%domain/logs/apache/error.log
        CustomLog /var/www/vhosts/%domain/logs/apache/access.log combined
</VirtualHost>

