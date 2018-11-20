# Use an official Python runtime as a parent image
FROM mysql:5.7

# Set the working directory to /docker_example
WORKDIR /ps

# Copy the current directory contents into the container at /docker_example
ADD . /ps

RUN apt-get clean && apt-get -y update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get -y upgrade && apt-get install -y python3 && \
    apt-get install -y python-pip && \
    apt-get -y autoremove && \
    apt-get -y autoclean
RUN touch /var/run/mysqld/mysqld.sock
RUN chown -R mysql /var/run/mysqld
RUN /etc/init.d/mysql restart
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV MYSQL_USER=root
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=ps

# Run manage.py when the container launches
#RUN python manage.py runserver
