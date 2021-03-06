# WSO2 Configurator

Configurator is a python module which provides features for configuring a server with set of name value pairs.
A template module needs to be created with a set of jinja template files and a configuration settings ini file for using
configurator for configuring a server.

### **How to use configurator**

Please follow below steps to proceed with the installation:

(1) Install python pip.
   ```
   sudo apt-get install python-pip
   ```

(2) Install jinja2 module.
   ```
   pip install Jinja2
   ```
(3) Build required template module in the path .

(4) Unzip and copy template module to `<configurator_home>/template-modules` folder. 

Final folder structure should look like below :
```
<configurator_home>
|-- conf
|   `-- logging_config.ini
|-- configparserutil.py
|-- configurator.log
|-- configurator.py
|-- constants.py
|-- __init__.py
`-- template-modules
    `-- <extracted template module>
```

  
(5) Run Configurator `<confiugrator_home>/configurator.py`.
   ```
   ./configurator.py
   ```

