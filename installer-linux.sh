#!/bin/bash

echo "$(date '+[%Y-%m-%d %H:%M:%S]') Installing the Python requirements..."
pip3 install -r ./requirements.txt

echo "Installing the application..."
APP_DIR="$HOME/correct-me"
echo "$(date '+[%Y-%m-%d %H:%M:%S]') Creating the directory... ($APP_DIR)"
if [ -d $APP_DIR ]; then
    echo "The directory already exists. Uninstall the existing version and run this installer again..."
    echo "$(date '+[%Y-%m-%d %H:%M:%S]') Installation failed."
    read -p "Press enter to exit..."
    exit 1
fi
mkdir $APP_DIR
cd $APP_DIR

echo "$(date '+[%Y-%m-%d %H:%M:%S]') Downloading..."
wget "https://github.com/farid-rajabi/correct-me/archive/refs/heads/main.zip"
ZIP_FILE=$(ls)
echo "$(date '+[%Y-%m-%d %H:%M:%S]') Extracting..."
unzip $ZIP_FILE

echo "$(date '+[%Y-%m-%d %H:%M:%S]') Tidying up..."
rm $ZIP_FILE
EXTRACTED_DIR=$(ls -d */)
mv ./$EXTRACTED_DIR* .
rm -fr ./$EXTRACTED_DIR
rm -fr ./screenshots/
rm -f ./.gitignore

echo "$(date '+[%Y-%m-%d %H:%M:%S]') Creating the executable..."
echo "clear" > ./CorrectMe.sh
echo "cd '$APP_DIR'" >> ./CorrectMe.sh
echo "python3 ./bin/main.py" >> ./CorrectMe.sh
chmod +x ./CorrectMe.sh

echo "$(date '+[%Y-%m-%d %H:%M:%S]') Creating the shortcut..."
echo "[Desktop Entry]
Name=Correct Me!
Exec=sh -c '$APP_DIR/CorrectMe.sh'
Terminal=true
Icon=$APP_DIR/icon.ico
Type=Application" > ./correct-me.desktop
chmod +x ./correct-me.desktop
mv ./correct-me.desktop "$HOME/.local/share/applications"

echo "$(date '+[%Y-%m-%d %H:%M:%S]') Installation completed."
read -p "Press enter to exit..."
exit 0
