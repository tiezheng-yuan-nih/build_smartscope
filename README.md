# build_smartscope
Build instance of containters for SmartScope.
All steps are tested in Rocky Linux

# build SmartScope for development
SmartScope is developed under Django web framework. 
The execution depends on some outside resource.

## build dependent resources
### Download image data: make you are in the sudo group and can
  access the data server. Data would be stored in the
  directory ./data.
  Note: the script below only works for NIEH-core team.
   Feel free to copy data from somewhere else in your case.
```
./bin/download_data.sh <data server>
```

### Download external plug-ins. Plug-ins would be stored in the 
   directory ./external_plugins
```
./bin/download_external_plugins.sh
```

### Install python modules of SerialEM. You do the installation one time.
```
cd SmartScope/SerialEM-python
sudo python3 setup.py install
```
Test the module serialem using the command
```
python3 -c "import serialem as sem"
```

### Make Redis is running and the port is 6379.
   Check status of Redis. The ping command would return "PONG"
```
sudo systemctl status redis.service
redis-cli ping
```
### Make MariaDB is running and all configurations are ready.
Here are the checking list required for smartscope launching.
Please all of them are correctly configure before starting smartscope.
- start mysql server
```
sudo systemctl status mysqld.service
```
- include database smartscope
Create a database
```
mysql -u root -p
```
```
CREATE DATABASE smartscope;
```
If you would like to dump database from somewhere else, you could
connect database server using root user, and create a database
known as "smartscope". Dump database backup into local database.
Here the dump file is 20230515_dump.sql.
```
sudo mysql -u root -p smartscope < 20230515_dump.sql
```
- confirm your hostname is localhost.
```
SELECT @@HOSTNAME;
```
If not, change the hostname to localhost
```
hostname
sudo hostname localhost
sudo systemctl restart mysqld.service
```
- confirm your port is 3306.
```
SELECT @@PORT;
```
- make unix socket is in the right place
confirm where is the socket file. In default /var/lib/mysql/mysql.sock
should be presented.
```
sudo find / -type s
```
```
sudo mkdir /run/mysqld
sudo chmod -R 755 /run/msyqld
sudo ln -s /var/lib/mysql/mysql.sock /run/mysqld/mysqld.sock
```




## Build Django project - SmartScope
- Download source code of SmartScope. Source code would be stored in the
   directory ./SmartScope. The next, you might as well create a virtual
   environments and install dependencies.
```
git clone git@github.com:tiezheng-yuan-nih/SmartScope.git
cd SmartScope
virtualenv venv
source venv/bin/activate
pip install -r Smartscope/requirements.txt
deactivate
```

- Configurations. First, you may create supperuser. It is recommended
   that you could create a super user for Django. skip this step 
   if super user exists. Second, if it is necessory, do migrations
   which migrate models to database.
```
source venv/bin/activate
<!-- create super user -->
python3 Smartscope/bin/manage.py createsuperuser
... (omit some steps)
<!-- migrate models -->
python3 Smartscope/bin/manage.py migrate
deactivate
```

- Launch the web server. Acces the web through http://localhost:8000.
   login user is the name and password of the supper user.
```
source venv/bin/activate
export mode=dev
python3 Smartscope/bin/manage.py runserver
```

pip install -e . --no-dependencies
manage.py runserver

- retrieve virtual environement
```
deactivate
```

- (Optional) Download documents
```
git clone git@github.com:NIEHS/SmartScope-docs.git
```

# Launch SmartScope in local machine

## Conditions before building SmartScope container
 - docker is installed and can be run without sudo permission.
 ```
 docker --version
 ```
 - make is installed.
 ```
 make --version
 ```
 - the port 3307 shouldnot be used. That would be used for database.
    the port 4800 shouldnot be used. That would be used by SmartScope.
    check ports occupied.
 ```
 netstat -ptln
 ```

## steps 
Retrieve repos from the remote
```
git clone git@github.com:tiezheng-yuan-nih/build_smartscope.git SmartScope
cd SmartScope
```

Some random images from the different magnifications out of an image bank
will be pulled and stored in ./testfiles.
SmartScope and depedent images will be pulled. After that 4 containers will
be built and started.
```
make local-build
```
For testing SmartScope, open browser, and login Smartscope using the url: http://localhost:48000.
In default, the user name is admin and password is "cryoemsmartscope".

The comand below would stop containers and delete sub-directories.
```
make local-stop
```



