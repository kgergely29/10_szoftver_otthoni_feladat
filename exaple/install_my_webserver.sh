#!/bin/bash

if [ "$USER" != "root" ]
then
    echo "Please run this as root or with sudo"
    exit 2
fi

httpref=/var/www/html/

# 5. feladat: Webszerver telepitese
apt install apache2 unzip php -y
/etc/init.d/apache2 start

# 6. feladat:, 10. feladat:
echo -n "Belépés a webszerver mappájába...  "
cd $httpref
echo "KÉSZ"

echo -n "Alapértelmezett fájlok törlése...  "
yes | rm -r *
echo "KÉSZ"

echo -n "Alapértelmezett fájl generálása... "
touch index.html
echo "<html>
<head>
    <title>Gereált oldal</title>
    <meta charset=\"UTF-8\">
</head>
<body>
    <p>Ez egy generált fájl, szerkessze a $httpref tartalmát az induláshoz.</p>
    <a href=\"mappa1\">mappa1</a></br>
    <a href=\"mappa2\">mappa2</a></br>
    <a href=\"mappa3\">mappa3</a></br>
    <a href=\"wordpress\">wordpress</a></br>
</body>
</html>" > index.html
echo "KÉSZ"

# 7. feladat:
echo -n "Webszerver almappák létrehozása... "
mkdir mappa1
mkdir mappa2
echo "KÉSZ"

# 8. feladat:, 10. feladat:
echo -n "Webszerver almappa fájlok...       "
echo "<a href=\"/\">vissza</a></br>
Hello az egyik mappabol." > mappa1/index.html
echo "<a href=\"/\">vissza</a></br>
Hello a masik mappabol." > mappa2/index.html
echo "LÉTREHOZVA"

# 9. feladat:, 10. feladat:
echo -n "Webszerver 3. almappa és fájlok... "
mkdir mappa3
echo "<a href=\"/\">vissza</a></br>
`ls /etc | grep "^a.*.conf$"`" > mappa3/index.html
echo "LÉTREHOZVA"

# 11. feladat:
echo -n "IP cím beállítása...               "
ip addr add 192.168.32.131/24 dev ens33
# Nem teljes feladat
echo "KÉSZ"

# 12. feladat:
echo -n "Wordpress telepítése...            "
cd ~
wget https://wordpress.org/latest.zip -q
unzip -q latest.zip
mv wordpress/ $httpref
rm latest.zip
echo "KÉSZ"
