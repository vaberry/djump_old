#!/bin/bash/
if [[ "$(python3 -V)" =~ "Python 3" ]]
then echo "python3 is installed..."
else echo "please install python" && exit 0
fi

echo “creating djump project...”
read -p "Project name: " projectName
cd ~/desktop
[ ! -d "djump" ] && mkdir djump
cd djump

if [ ! -d $projectName ] 
then echo "making project file" && mkdir $projectName
else echo "project already exists" && exit 0
fi

cd $projectName
if [ ! -d "env" ]
then python3 -m venv env
fi

cd env && . bin/activate && cd ..
pip install django gunicorn psycopg2-binary dj-database-url python-dotenv
if [ ! -d $projectName ]
then django-admin startproject $projectName
fi

cd $projectName

# update root files
pip freeze > requirements.txt
touch .env
cp ~/desktop/djump/djump_script/templates/root/.env .

touch .gitignore
cp ~/desktop/djump/djump_script/templates/root/.gitignore .

python manage.py startapp main
mkdir static && cd static && mkdir main && cd main
mkdir css img js fonts
cd css
touch style.css
cp ~/desktop/djump/djump_script/templates/root/style.css .

## settings
cd ../../../$projectName && rm settings.py
cp ~/desktop/djump/djump_script/templates/root/settings.py .
sed -i -e 's/template_settings/'$projectName'/' settings.py
rm settings.py-e

rm urls.py
touch urls.py
cp ~/desktop/djump/djump_script/templates/root/urls.py .

cd ../main
touch urls.py
cp ~/desktop/djump/djump_script/templates/app/urls.py .

rm views.py
touch views.py
cp ~/desktop/djump/djump_script/templates/app/views.py .

mkdir templates && cd templates
touch index.html
cp ~/desktop/djump/djump_script/templates/app/index.html .
touch home.html
cp ~/desktop/djump/djump_script/templates/app/home.html .
cd ..
touch forms.py


cd ../static/main
cp ~/desktop/djump/djump_script/templates/root/favicon.ico .
cd ../../

cd ~/desktop/djump/$projectName/$projectName
code .
