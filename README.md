# My Path

My Path is a web application that uses machine learning to assist users in making informed career choices. By filling out a questionnaire, the system predicts the most suitable career for the user based on their responses.


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.
You can either run the application using Docker, or install all the components separately on your machine.

### Locally
#### Ruby

Use `rbenv` or another version manager to install and use the configured version of Ruby. 
You can check this on the `.ruby-version` file.

#### PostgreSQL

Install postgresql with homebrew using:
```
brew install postgresql
```

To start postgresql use:
```
brew services start postgresql # on mac
sudo service postgresql start  # on wsl or linux
```

#### Python

You need to have Python 3 installed on your machine. To install it use: 
```
brew install python3 # on mac
sudo apt-get install python3.8 # on wsl or linux
```

After installing Python, you need to install a few dependencies. You can do this using `pip`, the Python package manager.
You can get it with the following command:
```
sudo apt-get install python3-pip
```

Now install the required Python packages:
```
pip3 install numpy pandas scikit-learn joblib
```

#### Database Setup

To setup the database you can use the standard rails command:
```
rails db:setup
```

To keep your schema up to date with the latest migrations use

````
rails db:schema:load
````

#### Running the Application

Start the Rails server:
```
rails server
```

The application should now be running at http://localhost:3000.

### Docker

To run the application locally using Docker you will need to have Docker installed

Then you can just do:
```
docker compose up
```

The application should now be running at http://localhost:3000.

If you do not have the database created locally yet you can do

```

docker compose run --rm app rails db:setup

```

To interact with the system via the console use:
```

docker compose run --rm app rails c

```


## Testing

The project uses `RSpec` for testing.
To run the tests use:
```
bundle exec rspec
```

To run the tests using docker, run the command with docker compose:
```
docker compose run --rm app rspec
```
