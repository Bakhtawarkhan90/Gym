# Use the official Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Install the necessary packages
RUN pip install Flask mysql-connector-python

# Expose the port Flask will run on
EXPOSE 5000

# Set the environment variables for MySQL
ENV MYSQL_HOST=database \
    MYSQL_USER=root \
    MYSQL_PASSWORD=kali \
    MYSQL_DB=gym

# Command to run app

CMD ["python3","app.py"]