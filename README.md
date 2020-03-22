# Ruptiva Code Challenge Back-end

### running application

download the project

```
git clone https://github.com/oliveira-andre/Ruptiva-Code-Challenge-Back-end.git
```

create a dotenv file

```
touch .env
```

put this code

```
db_host=postgres
db_port=5432
db_user=postgres
db_pass=root
```

run the application using docker

```
sudo docker-compose up --build
```

create and migrate the database

```
sudo docker-compose run --rm web_app bundle exec rails db:create db:migrate db:seed
```

and right now you are able to run the application

if you would like to run the test

```
sudo docker-compose run --rm web_app bundle exec rspec
```

and if you want see the rubocop offenses
```
sudo docker-compose run --rm web_app bundle exec rubocop
```

### How to use Application

[if you preffer the postman docs click here](https://raw.githubusercontent.com/oliveira-andre/Ruptiva-Code-Challenge-Back-end/master/tmp/storage/ruptiva_code_challenge.postman_collection.json)

Registartions

POST create

```
curl  --request POST 'https://ruptiva-code-challenge-back-en.herokuapp.com/api/v1/users' \
--header 'Content-Type: application/json' \
--data-raw '{ 
	"user":	{ 
		"first_name": "Andre",
		"last_name": "Oliveira",
		"email": "safe@root.com",
		"role": "admin",
		"password": "123456",
		"password_confirmation": "123456"
	}
}'
```

Sessions

POST create

```
curl  --request POST 'https://ruptiva-code-challenge-back-en.herokuapp.com/api/v1/users/sign_in' \
--header 'Content-Type: application/json' \
--data-raw '{ 
	"user": {
		"email": "root@root.com",
		"password": "123456"
	}
}'
```

Users

GET index

```
curl  --request GET 'https://ruptiva-code-challenge-back-en.herokuapp.com/api/v1/users' \
--header 'Authorization: kkZxYyU3eBXSsXE1Jyb3'
```

GET show

```
curl  --request GET 'https://ruptiva-code-challenge-back-en.herokuapp.com/api/v1/users/1' \
--header 'Authorization: kkZxYyU3eBXSsXE1Jyb3'
```

PUT update

```
curl  --request PUT 'https://ruptiva-code-challenge-back-en.herokuapp.com/api/v1/users/1' \
--header 'Content-Type: application/json' \
--header 'Authorization: kkZxYyU3eBXSsXE1Jyb3' \
--data-raw '{
	"user": {
		"first_name": "andre",
		"role": "admin"
	}
}'
```

DELETE destroy

```
curl  --request DELETE 'https://ruptiva-code-challenge-back-en.herokuapp.com/api/v1/users/2' \
--header 'Authorization: kkZxYyU3eBXSsXE1Jyb3'
```

### Gems

Active Model Serializer

```
with the serializer we can manage better the returns of an api
```

Dotenv rails

```
with the dotenv i can create the .env file and the application will read it by default
```

Simple TokenAuthentication

```
i used this GEM when she was by default on devise, then i used in this application to manage the toke of user (on login)
```

Factory Bot Rails

```
this is my prefered factory, i can manage the database of fixures too easy on the factories folder, and the rspec has all compatibility
```

Ffaker

```
i use to generate random data with this i can get better and randoms tests
```

Shoulda matchers

```
i love the syntax of ruby, and i love to keep it simple and elegant, for this i use this gem to code elegatly and get good tests
```

Pry-rails

```
with this gem i can get better responses on rails console, i hate how the irb show the data, for this i prefer to use pry
```
