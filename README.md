# build_smartscope
Build instance of containters for SmartScope.
All steps are tested in Rocky Linux



## Launch SmartScope in local machine

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



