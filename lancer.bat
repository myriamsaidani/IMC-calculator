@echo off
setlocal enabledelayedexpansion

set JAVAFX_PATH=C:\javafx-sdk-24.0.1\lib
set MODULES=javafx.controls,javafx.fxml

echo Vérification de JavaFX...
if not exist "%JAVAFX_PATH%\javafx.controls.jar" (
    echo.
    echo ERREUR : JavaFX n'est pas installé correctement.
    echo Veuillez télécharger JavaFX SDK depuis :
    echo https://gluonhq.com/products/javafx/
    echo.
    echo Puis extrayez-le dans C:\javafx-sdk-24.0.1\
    pause
    exit /b 1
)

echo.
echo Compilation en cours...

if not exist "target\classes" mkdir target\classes

javac --module-path "%JAVAFX_PATH%" --add-modules %MODULES% -d target/classes src/main/java/com/imc/Main.java src/main/java/com/imc/controllers/*.java src/main/java/com/imc/models/*.java src/main/java/com/imc/utils/*.java

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERREUR lors de la compilation.
    echo.
    echo Assurez-vous que :
    echo 1. Java 24 est installé
    echo 2. JavaFX est extrait dans C:\javafx-sdk-24.0.1\
    echo 3. Le chemin est correct : %JAVAFX_PATH%
    pause
    exit /b 1
)

echo.
echo Copie des ressources...
xcopy /s /y "src\main\resources" "target\classes"

echo.
echo Téléchargement du pilote MySQL...
if not exist "target\classes\lib\mysql-connector-j-8.0.33.jar" (
    curl -o target/classes/lib/mysql-connector-j-8.0.33.jar https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar
    if %ERRORLEVEL% NEQ 0 (
        echo.
        echo ERREUR : Impossible de télécharger le pilote MySQL.
        pause
        exit /b 1
    )
)

echo Lancement de l'application...
java --module-path "%JAVAFX_PATH%" --add-modules %MODULES% -cp "target/classes;target/classes/lib/*" com.imc.Main

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERREUR lors du lancement de l'application.
    echo Vérifiez que JavaFX est correctement installé.
    pause
    exit /b 1
)

endlocal
