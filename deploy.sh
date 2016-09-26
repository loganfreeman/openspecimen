sudo su - openspecimen
cd
cd releases
sftp public@demo.openspecimen.org:/test_builds/installer/openspecimen_v3.3.RC1_CE.zip
unzip openspecimen_v3.3.RC1_CE.zip -d openspecimen_v3.3.RC1_CE
mv openspecimen_v3.3.b20_CE* archive/
cd openspecimen_v3.3.RC1_CE
chmod +x *.sh
./openspecimen.sh -q -varfile ../properties.varfile
cd plugins
sftp public@demo.openspecimen.org:/test_builds/plugin/*1.1.0.jar 
sftp public@demo.openspecimen.org:/test_builds/*1.1.0.jar
mkdir -p archive/plugins
./archive_plugins 1.0.0 1.1.0 /home/openspecimen/releases/archive/plugins
