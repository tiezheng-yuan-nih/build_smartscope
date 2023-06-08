# build_smartscope
Build instance of containters for SmartScope.
All steps are tested in Rocky Linux


## Conditions before building SmartScope container
 - account in in sudo group
 - the port 3306 shouldnot be used. That would be used for database
 - the port 4800 shouldnot be used. That would be used by SmartScope


## Steps

### Step 1: retrieve repos

```
git clone git@github.com:tiezheng-yuan-nih/build_smartscope.git SmartScope
cd SmartScope
```

### build SmartScope container
For local machine
```
make local-start
```

For product server
```
make prod-start
```

### stop SmartScope container
For local machine
```
make local-stop
```

For product server
```
make prod-stop
```


