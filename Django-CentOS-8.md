## How to install Django in centos8


```
pip3 install virtualenv
mkdir /myworkspace
cd /myworkspace/
```

## Installing Django
```
mkdir /myworkspace/django-project-1
virtualenv /myworkspace/django-project-1
source /myworkspace/django-project-1/bin/activate
pip3 install django
django-admin startproject first_project
cd first_project/

(virtENV) [root@chop-rh8-01 first_project-1]# python manage.py runserver
Watching for file changes with StatReloader
Performing system checks...

System check identified no issues (0 silenced).

You have 18 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
Run 'python manage.py migrate' to apply them.
May 19, 2023 - 05:19:03
Django version 3.2.19, using settings 'first_project.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.

```
## Creating First App.
```
python manage.py startapp first_app

(django-project-1) [root@chop-rh8-01 first_project]# pwd
/myworkspace/first_project
(django-project-1) [root@chop-rh8-01 first_project]# ls first_app/
admin.py  apps.py  __init__.py  migrations  models.py  tests.py  views.py

(django-project-1) [root@chop-rh8-01 first_project]# cat first_app/views.py

from django.shortcuts import render
from django.http import HttpResponse
# Create your views here.

def index(request):
    return HttpResponse("Hello World")

(django-project-1) [root@chop-rh8-01 first_project]# cat first_project/urls.py
from django.conf.urls import url
from django.contrib import admin
from django.urls import path
from first_app import views

urlpatterns = [
    url(r'^$',views.index,name='index'),
    url(r'^admin/', admin.site.urls),
]

```
## working with Migrations
```
(django-project-2) [root@chop-rh8-01 second_project]# python manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
  Applying auth.0012_alter_user_first_name_max_length... OK
  Applying sessions.0001_initial... OK
  
  
(django-project-2) [root@chop-rh8-01 second_project]# python manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  No migrations to apply.
(django-project-2) [root@chop-rh8-01 second_project]#

(django-connect) [root@chop-rh8-01 first_project]# python manage.py makemigrations django_connect
Migrations for 'django_connect':
  django_connect/migrations/0001_initial.py
    - Create model Topic
    
(django-connect) [root@chop-rh8-01 first_project]# python manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, django_connect, sessions
Running migrations:
  Applying django_connect.0001_initial... OK




```
