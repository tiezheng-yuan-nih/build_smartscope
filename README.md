# build_smartscope
Build instance of containters for SmartScope.
All steps are tested in Rocky Linux

## build SmartScope for development
SmartScope is developed under Django web framework. 
The execution depends on some outside resource.

- Download image data: make you are in the sudo group and can
  access the data server. Data would be stored in the
  directory ./data.
  Note: the script below only works for NIEH-core team.
   Feel free to copy data from somewhere else in your case.
```
./bin/download_data.sh <data server>
```

- Download external plug-ins. Plug-ins would be stored in the 
   directory ./external_plugins
```
./bin/download_external_plugins.sh
```
- Install python modules of SerialEM. You do the installation one time.
```
cd SmartScope/SerialEM-python
sudo python3 setup.py install
```
Test the module serialem using the command
```
python3 -c "import serialem as sem"
```

- Make Redis is running and the port is 6379.
   Check status of Redis. The ping command would return "PONG"
```
sudo systemctl status redis.service
redis-cli ping
```
- Make MariaDB is running and the port is 3306.
```
sudo systemctl status mysqld.service
mysql -u root -p
```

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

- Create supperuser. It is recommended that you could create 
   a super user for Django. skip this step if super user exists.
```
source venv/bin/activate
python3 Smartscope/bin/manage.py createsuperuser
deactivate
```

- Launch the web server. Acces the web through http://localhost:8000
```
source venv/bin/activate
export mode=dev
python3 Smartscope/bin/manage.py runserver
deactivate
```


## Launch SmartScope in local machine

### Conditions before building SmartScope container
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

### steps 
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



