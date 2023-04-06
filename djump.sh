#!/bin/bash/

# set djump variables
env=$(<djump_files/templates/root/.env)
git=$(<djump_files/templates/root/.gitignore)
style=$(<djump_files/templates/root/style.css)
settings=$(<djump_files/templates/root/settings.py)
root_urls=$(<djump_files/templates/root/urls.py)
favicon=$(<djump_files/templates/root/favicon.ico)

app_urls=$(<djump_files/templates/app/urls.py)
views=$(<djump_files/templates/app/views.py)
index=$(<djump_files/templates/app/index.html)
home=$(<djump_files/templates/app/home.html)
##

#set user project name varible
projName=$1
##

if [[ ! "$(python3 -V)" =~ "Python 3" ]]; then echo "please install python" && exit 0; fi
cd ~/desktop
if [ ! -d "djump" ]; then echo "making djump folder on your desktop" && mkdir djump; fi
cd djump
if [ ! -d $projName ]; then echo "making '$projName' project folder in djump" && mkdir $projName; else echo "project already exists, try a different name" && exit 0; fi
cd $projName && python3 -m venv env
cd env && . bin/activate && cd ..
pip install django gunicorn psycopg2-binary dj-database-url python-dotenv
django-admin startproject $projName
cd $projName
pip freeze > requirements.txt

touch .env
echo "$env" > .env

touch .gitignore
echo "$git" > .gitignore

mkdir static && cd static
mkdir main && cd main
touch favicon.ico
echo "$favicon" > favicon.ico
mkdir css img js fonts && cd css
touch style.css
echo "$style" > style.css

cd ../../../$projName && rm settings.py

touch settings.py
echo "$settings" > settings.py
sed -i -e 's/template_settings/'$projName'/' settings.py
rm settings.py-e

rm urls.py
touch urls.py
echo "$root_urls" > urls.py

cd ..

python manage.py startapp main && cd main

touch urls.py
echo "$app_urls" > urls.py

rm views.py
touch views.py
echo "$views" > views.py

mkdir templates && cd templates
touch index.html
echo "$index" > index.html
touch home.html
echo "$home" > home.html
cd ..
touch forms.py

cd ..
code .
