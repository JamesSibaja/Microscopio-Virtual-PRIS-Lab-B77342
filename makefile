.PHONY: setup run

# Configurar el entorno
# docker compose exec web python virtual_microscope/manage.py makemigrations

# sudo a # pip3 install -r requirements.txt
setup:
 	# sudo apt-get install docker-ce docker-ce-cli containerd.io
	export DJANGO_SETTINGS_MODULE=settings
	mkdir -p virtual_microscope/media/slide virtual_microscope/media/archivo
	sudo apt-get install python3-pip
	sudo apt-get install python3-venv
	python3 -m venv virtual_microscope/venv
	. virtual_microscope/venv/bin/activate && pip install --upgrade pip
	
	sudo docker compose build redis db gunicorn daphne celery nginx

    # Iniciar y configurar las bases de datos PostgreSQL
	docker compose up --no-build -d --no-recreate redis db gunicorn daphne celery nginx

	
	docker compose exec gunicorn python manage.py makemigrations
	docker compose exec gunicorn python manage.py migrate
	sleep 10
	
    # Crear un superusuario (cambiar los valores de acuerdo a tus necesidades) 
	# docker compose exec gunicorn python manage.py createsuperuser --username=postgres --email=jsibajagranados2@gmail.com
	@docker compose exec gunicorn python manage.py shell -c "from django.contrib.auth.models import User; from getpass import getpass; username='postgres'; email='jsibajagranados2@gmail.com'; password=getpass('Enter password for superuser: '); User.objects.create_superuser(username, email, password) if not User.objects.filter(username=username).exists() else print('Superuser already exists')"

	
generate-docs:
	sudo docker compose build documentation
	docker compose run documentation make -C virtual_microscope/docs html
	cd virtual_microscope/docs/build/html && python3 -m http.server 8080

generate-pdf: generate-docs
	docker compose run documentation make -C virtual_microscope/docs latexpdf

# Arrancar el servidor Django y Celery
run:
	export DJANGO_SETTINGS_MODULE=virtual_microscope.virtual_microscope.settings
	docker compose up --no-build --no-recreate redis db gunicorn daphne celery nginx
	docker compose exec gunicorn python manage.py makemigrations
	docker compose exec gunicorn python manage.py migrate

# run-prod:
# 	export DJANGO_SETTINGS_MODULE=virtual_microscope.virtual_microscope.settings
# 	docker compose -f docker-compose.prod.yml up
# 	docker compose exec gunicorn python manage.py makemigrations
# 	docker compose exec gunicorn python manage.py migrate

stop:
	docker compose down