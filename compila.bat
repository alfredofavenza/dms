@echo off
echo Compiling... %1
cd "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\dms\WEB-INF\classes%2"
javac -cp c:\glassfish4\glassfish\modules\javax.servlet-api.jar;"C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\dms\WEB-INF\classes" %1
echo Compiling... %1: done!
cd "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\dms"