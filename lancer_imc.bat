@echo off
set PATH_TO_FX=C:\javafx-sdk-24.0.1\lib
set MODULES=javafx.controls,javafx.fxml
set MAIN_CLASS=com.imc.Main

cd /d "C:\Users\USER\Desktop\IMC"

:: Chemin vers le pilote MySQL
set MYSQL_DRIVER=target\classes\lib\mysql-connector-j-8.0.33.jar
set CLASSPATH=target\classes;%PATH_TO_FX%\*;%MYSQL_DRIVER%

echo Compilation du projet...
javac --module-path "%PATH_TO_FX%" --add-modules %MODULES% -d target/classes -cp "%CLASSPATH%" src\main\java\com\imc\*.java src\main\java\com\imc\controllers\*.java src\main\java\com\imc\models\*.java src\main\java\com\imc\utils\*.java

echo.
echo Copie des ressources...
if not exist "target\classes\fxml" mkdir "target\classes\fxml"
xcopy /Y "src\main\resources\fxml\*.fxml" "target\classes\fxml\"

echo.
echo Téléchargement du pilote MySQL...
if not exist "%MYSQL_DRIVER%" (
    echo Le pilote MySQL n'est pas trouvé. Téléchargement en cours...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-j-8.0.33.jar', '%MYSQL_DRIVER%')"
)

echo.
echo Lancement de l'application...
java --module-path "%PATH_TO_FX%" --add-modules %MODULES% -cp "%CLASSPATH%" %MAIN_CLASS%

pause
