FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y apache2 && \
    a2enmod ssl

COPY paginas/Deafult-website /var/www/html/Deafult-website
COPY paginas/usuario-birt /var/www/html/usuario-birt

COPY 000-default.conf /etc/apache2/sites-available/
COPY user-website.conf /etc/apache2/sites-available/
COPY apache2.conf /etc/apache2/
COPY htpasswd /etc/apache2/ 

COPY servidor.key /etc/ssl/
COPY servidor.pem /etc/ssl/

RUN a2ensite user-website.conf && \
    a2ensite 000-default.conf

EXPOSE 80 443

#para iniciar Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]