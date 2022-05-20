REM http://wp.xin.at/archives/3309
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
SET totalreadvolume=0
SET totalwritevolume=0
SET totalreadTiB=0
SET totalwriteTiB=0
SET volindex=0
FOR %%I IN (1,2) DO SET "volume[%%I]=0"
 
FOR /L %%I IN (1 1 12) DO (
  FOR /F "usebackq" %%V IN (`smartctl -x -d areca^,%%I/2 /dev/arcmsr0 ^| grep ^
-e "read:" -e "write:" ^| tr -s " " ^| cut -d " " -f7 ^| cut -d "," -f1`) DO (
    SET /A volindex += 1
    SET "volume[!volindex!]=%%V"
  )
  SET /A totalreadvolume += !volume[1]!
  SET /A totalwritevolume += !volume[2]!
  SET volindex=0
)
SET /A totalreadTiB = "%totalreadvolume% / 1024"
SET /A totalwriteTiB = "%totalwritevolume% / 1024"
SET /A parityreadTiB = "%totalreadTiB% / 6"
SET /A paritywriteTiB = "%totalreadTiB% / 6"
SET /A totaluserreadTiB = "%totalreadTiB% - %parityreadTiB%"
SET /A totaluserwriteTiB = "%totalwriteTiB% - %paritywriteTiB%"
 
 
ECHO ^<b^>Areca ARC-1883ix-12 RAID controller status:^<br^> > "Z:\web\xin\raid6^
stats\raid6stats_temp.txt.html"
 
ECHO ==========================================^</b^>^<br^>^<br^> >> "Z:\web\xi^
n\raid6stats\raid6stats_temp.txt.html"
"C:\Program Files (x86)\system\ArcCLI\cli.exe" sys info | grep -e "Main Process^
or" -e CPU -e "System Memory" -e "Controller Name" | sed -e "s/1200MHz/PowerPC^
 476 dual-core, 1200MHz/g" -e "s/SCache\sSize\s\s/L2 Cache Size/g" -e "s/\s/\&^
nbsp;/g" -e "s/^/\&nbsp;\&nbsp;/g" -e "s/$/<br>/g" >> "Z:\web\xin\raid6stats\r^
aid6stats_temp.txt.html"
 
"C:\Program Files (x86)\system\ArcCLI\cli.exe" hw info | grep -e "CPU Temperatu^
re" -e "Controller Temp" -e "CPU Fan" -e "12V" -e "5V" -e "3\.3V" -e "IO Volta^
ge" -e "DDR3" -e "CPU VCore" -e "Ethernet" -e "Battery Status" -e "Chip Temp" ^
| sed -e "s/\sC$/\&deg;C/g" -e "s/\sV$/V/g" -e "s/\sRPM$/rpm/g" -e "s/\x25/F/g^
" -e"s/^\s\s//g" -e "s/\s:\s/   : /g" -e "s/Chip\sTemp\s\s\s\s\s\s\s\s\s/SAS E^
xpander Temp\./g" -e "s/\s/\&nbsp;/g" -e "s/^/\&nbsp;\&nbsp;/g" -e "s/$/<br>/g^
" >> "Z:\web\xin\raid6stats\raid6stats_temp.txt.html"
 
ECHO ^<br^>^<br^>^<br^>^<br^>^<b^>RAID ^&amp; volume set status:^<br^> >> "Z:\w^
eb\xin\raid6stats\raid6stats_temp.txt.html"
ECHO ========================^</b^>^<br^>^<br^> >> "Z:\web\xin\raid6stats\raid6^
stats_temp.txt.html"
 
ECHO ^&nbsp;^&nbsp;RAID set:^<br^> >> "Z:\web\xin\raid6stats\raid6stats_temp.tx^
t.html"
ECHO ^&nbsp;^&nbsp;--------^<br^> >> "Z:\web\xin\raid6stats\raid6stats_temp.txt^
.html"
ECHO ^&nbsp;^&nbsp;^&nbsp;^&nbsp;#^&nbsp;Name^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp^
;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^
^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;Disks^&nbsp;TotalCap^&nbsp;^&n^
bsp;^&nbsp;FreeCap^&nbsp;MinDiskCap^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&^
nbsp;^&nbsp;^&nbsp;State^<br^> >> "Z:\web\xin\raid6stats\raid6stats_temp.txt.ht^
ml"
 
"C:\Program Files (x86)\system\ArcCLI\cli.exe" rsf info | grep -e Taranis | sed^
 -e "s/\sTaranis\sRAID-6\sC/Taranis RAID-6 CryptoArray/g" -e "s/^\s/  /g" -e "s^
/\s/\&nbsp;/g" -e "s/^/\&nbsp;\&nbsp;/g" -e "s/$/<br>/g" >> "Z:\web\xin\raid6st^
ats\raid6stats_temp.txt.html"
 
ECHO ^<br^>^&nbsp;^&nbsp;Volume set:^<br^> >> "Z:\web\xin\raid6stats\raid6stats^
_temp.txt.html"
ECHO ^&nbsp;^&nbsp;----------^<br^> >> "Z:\web\xin\raid6stats\raid6stats_temp.t^
xt.html"
ECHO ^&nbsp;^&nbsp;^&nbsp;^&nbsp;#^&nbsp;Name^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp^
;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^
^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;UsableCap^&nbsp;^
Ch/Id/Lun^&nbsp;^&nbsp;State^<br^> >> "Z:\web\xin\raid6stats\raid6stats_temp.tx^
t.html"
 
"C:\Program Files (x86)\system\ArcCLI\cli.exe" vsf info | grep -e Taranis | sed^
 -e "s/Taranis\sRAID-6\sC\sTaranis\sRAID-6\sCRaid6/Taranis RAID-6 CryptoArray/g^
" -e "s/\s/\&nbsp;/g" -e "s/^/\&nbsp;\&nbsp;/g" -e "s/$/<br>/g" >> "Z:\web\xin\^
raid6stats\raid6stats_temp.txt.html"
 
ECHO ^<br^>^<br^>^<br^>^<b^>Global array S.M.A.R.T. information:^<br^> >> "Z:\w^
eb\xin\raid6stats\raid6stats_temp.txt.html"
ECHO ===================================^</b^>^<br^>^<br^> >> "Z:\web\xin\raid6^
stats\raid6stats_temp.txt.html"
ECHO ^&nbsp;^&nbsp;Total data read from array (raw, with N+P parity data) :^
 ~%totalreadTiB% TiB^<br^> >> "Z:\web\xin\raid6stats\raid6stats_temp.txt.html"
ECHO ^&nbsp;^&nbsp;Total data written to array (raw, with N+P parity data):^
 ~%totalwriteTiB% TiB^<br^>^<br^> >> "Z:\web\xin\raid6stats\raid6stats_temp.txt^
.html"
ECHO ^&nbsp;^&nbsp;Total data read from array (user data) : ~%totaluserreadTiB%^
 TiB^<br^> >> "Z:\web\xin\raid6stats\raid6stats_temp.txt.html"
ECHO ^&nbsp;^&nbsp;Total data written to array (user data):^
 ~%totaluserwriteTiB% TiB^<br^>^<br^> >> "Z:\web\xin\raid6stats\raid6stats_temp^
.txt.html"
ECHO ^&nbsp;^&nbsp;^<em^>^<span style="font-size: 8pt;"^>Note: Parity data is i^
ncluded in raw total reads, because the controller is^<br^> >> "Z:\web\xin\raid^
6stats\raid6stats_temp.txt.html"
ECHO ^&nbsp;^&nbsp;configured to read ^&amp; discard parity data to minimize re^
-seeks and optimize^<br^> >> "Z:\web\xin\raid6stats\raid6stats_temp.txt.html"
ECHO ^&nbsp;^&nbsp;for sequential reading performance.^</span^>^</em^>^<br^> >>^
 "Z:\web\xin\raid6stats\raid6stats_temp.txt.html"
 
ECHO ^<br^>^<br^>^<br^>^<b^>Per-Disk S.M.A.R.T. information:^<br^> >> "Z:\web\x^
in\raid6stats\raid6stats_temp.txt.html"
ECHO ===============================^</b^>^<br^> >> "Z:\web\xin\raid6stats\raid^
6stats_temp.txt.html"
 
FOR /L %%M IN (1 1 12) DO (
  ECHO ^<br^> >> "Z:\web\xin\raid6stats\raid6stats_temp.txt.html"
  ECHO ^&nbsp;^&nbsp;Disk %%M:^<br^> >> "Z:\web\xin\raid6stats\raid6stats_temp.^
txt.html"
  ECHO ^&nbsp;^&nbsp;-------^<br^> >> "Z:\web\xin\raid6stats\raid6stats_temp.tx^
t.html"
  smartctl -a -d areca,%%M/2 /dev/arcmsr0 | grep -e "Vendor[:space:]" -e Produc^
t -e "User Capacity" -e "Rotation Rate" -e "Transport Protocol" -e "Current Dri^
ve Temperature" -e "Accumulated start-stop cycles" -e "Accumulated load-unload ^
cycles" -e "Elements in grown defect list" | sed -e "s/\sC$/\&deg;C/g" -e "s/Ve^
ndor:\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s/Vendor                        : /g" -e "s/P^
roduct:\s\s\s\s\s\s\s\s\s\s\s\s\s\s/Product                       : /g" -e "s/U^
ser\sCapacity:\s\s\s\s\s\s\s\s/User capacity                 : /g" -e "s/Rotati^
on\sRate:\s\s\s\s\s\s\s\s/Rotation rate                 : /g" -e "s/Current\sDr^
ive\sTemperature:\s\s\s\s\s/Current drive temperature     : /g" -e "s/start-sto^
p\scycles:\s\s/start-stop cycles : /g" -e "s/grown\sdefect\slist:\s/grown defec^
t list : /g" -e "s/load-unload\scycles:\s\s/load-unload cycles: /g" -e "s/\s/\&^
nbsp;/g" -e "s/^/\&nbsp;\&nbsp;\&nbsp;\&nbsp;/g" -e "s/$/<br>/g" >> "Z:\web\xin^
\raid6stats\raid6stats_temp.txt.html"
 
  smartctl -H -d areca,%%M/2 /dev/arcmsr0 | grep Health | sed -e "s/Status:/Sta^
tus           :/g" -e "s/\s/\&nbsp;/g" -e "s/^/\&nbsp;\&nbsp;\&nbsp;\&nbsp;/g" ^
-e "s/$/<br>/g" >> "Z:\web\xin\raid6stats\raid6stats_temp.txt.html"
)
 
ECHO ^<br^>^<br^>^<br^>^<br^>^<em^>Last update: >> "Z:\web\xin\raid6stats\raid6^
stats_temp.txt.html"
DATE /T >> "Z:\web\xin\raid6stats\raid6stats_temp.txt.html"
ECHO (DD.MM.YYYY),^  >> "Z:\web\xin\raid6stats\raid6stats_temp.txt.html"
TIME /T >> "Z:\web\xin\raid6stats\raid6stats_temp.txt.html"
ECHO ^</em^> >> "Z:\web\xin\raid6stats\raid6stats_temp.txt.html"
 
COPY /b /Y "Z:\web\xin\raid6stats\header.html" + "Z:\web\xin\raid6stats\raid6st^
ats_temp.txt.html" + "Z:\web\xin\raid6stats\footer.html" "Z:\web\xin\raid6stats^
\raid6stats.html"
 
ENDLOCAL
