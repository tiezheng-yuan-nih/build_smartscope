# build_smartscope
Build instance of containters for SmartScope.
All steps are tested in Rocky Linux


## Conditions before building SmartScope container
 - docker is installed and can be run without sudo permission.
 ```
 docker --version
 ```
 - make is installed.
 ```
 make --version
 ```
 - the port 3306 shouldnot be used. That would be used for database.
    the port 4800 shouldnot be used. That would be used by SmartScope.
    check ports occupied.
 ```
 netstat -ptln
 ```


## Launch SmartScope in local machine

### Step 1: retrieve repos from the remote

```
git clone git@github.com:tiezheng-yuan-nih/build_smartscope.git SmartScope
cd SmartScope
```

### Step 2: build and run SmartScope container locally
For local machine
```
make local-start
```

### Step3: test SmartScope
    open browser, and login Smartscope using the url: http://localhost:48000. In default, 
the user name is admin and password is "cryoemsmartscope".

### Step4: stop SmartScope container
For local machine
```
make local-stop
```



