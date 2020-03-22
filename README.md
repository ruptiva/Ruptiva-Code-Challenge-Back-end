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

[if you preffer the postman docs click here](https://documenter.getpostman.com/view/2522711/SzS8sQLA?version=latest)

Registartions

POST create

```
curl --location --request POST '/users' \
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
curl --location --request POST '/users/sign_in' \
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
curl --location --request GET '/users' \
--header 'Authorization: kkZxYyU3eBXSsXE1Jyb3'
```

GET show

```
curl --location --request GET '/users/1' \
--header 'Authorization: kkZxYyU3eBXSsXE1Jyb3'
```

PUT update

```
curl --location --request PUT '/users/1' \
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
curl --location --request DELETE '/users/2' \
--header 'Authorization: kkZxYyU3eBXSsXE1Jyb3'
```
