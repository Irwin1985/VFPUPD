*--------------------------------------------------------------------------------------
* MAIN.PRG
*--------------------------------------------------------------------------------------

PUBLIC m.pcFolderStyle
LOCAL lcPath

SET BELL OFF
SET HOURS TO 24

m.lcPath = ADDBS(JUSTPATH(SYS(16,1)))

SET DEFAULT TO (m.lcPath)

SET CLASS TO vcx\FoxRibbon.vcx 
SET CLASS TO vcx\VfpUpd.vcx additive
SET CLASS TO vcx\MyDesigns.vcx ADDITIVE

DO SYSTEM.APP

IF VARTYPE(_SCREEN.oRibbon) = "O"
	_SCREEN.REMOVEOBJECT('oRibbon')
ENDIF
_SCREEN.NEWOBJECT('oRibbon','RibbonSettings')

*-- Open DBF
USE (HOME(2) + "\Northwind\Customers.dbf") IN SELECT("Customers") NOUPDATE 
*

*--Default folder
m.pcFolderStyle = "Styles"

WITH _SCREEN.oRibbon
	*--Other Style
	*--.FileIni = SYS(5) + CURDIR() + pcFolderStyle + "\Black.ini"
	*--.Settings()
	*--.ReDraw()

	*--Language (See the folder LNG)
	*--.LANGUAGE = "English"
	.LANGUAGE = "Español"
	*--Show time out progress bar in MessageBox
	.ShowProgressMessageBox = .T.
	*--Calendars
	.c_FirstDayWeek = 2
	*--Holidays of the week
	.c_1SunHoli = .T.
	.c_2MonHoli = .F.
	.c_3TueHoli = .F.
	.c_4WedHoli = .F.
	.c_5ThuHoli = .F.
	.c_6FriHoli = .F.
	.c_7SatHoli = .T.
ENDWITH
*------------------------------------

SET DATE DMY
SET CENTURY ON


*------------------------------------------------------------------------------------------------------------------------------------*
* Este es el bloque de código que deberás incluir en tu PRG principal.
* 
* ARCHIVOS NECESARIOS:
*
* 1. Libreria 	: vfpconnection.fll
* 2. Clase 		: vfpupd.vcx
* 3. Programa	: vfpupd.prg
*
*------------------------------------------------------------------------------------------------------------------------------------*

IF VARTYPE(_SCREEN.oFtp) = "O"
	_SCREEN.REMOVEOBJECT('oFtp')
ELSE &&VARTYPE(_SCREEN.oFtp) = "O"
ENDIF &&VARTYPE(_SCREEN.oFtp) = "O"
_SCREEN.NEWOBJECT('oFtp','FtpSettings')

&& Configuración de las Credenciales de la FTP
_SCREEN.oFtp.Host 			= "ftp.260mb.net"
_SCREEN.oFtp.Login 			= "n260m_20137769"
_SCREEN.oFtp.PassWord 		= "rinconfo"
_SCREEN.oFtp.DirApp 		= "/htdocs/downloads/upd/"
_SCREEN.oFtp.AppName 		= "foxribbon.exe"
_SCREEN.oFtp.RutaExe 		= ADDBS(SYS(5)+SYS(2003))
_SCREEN.oFtp.AppVersion		= "0"
_SCREEN.oFtp.AppSubVersion	= "14"
_SCREEN.oFtp.AppRevision	= "4"
*------------------------------------------------------------------------------------------------------------------------------------*

DO FORM FORMS\MAIN
READ EVENTS

RELEASE CLASSLIB vcx\FoxRibbon.vcx, vcx\MyDesigns.vcx
CLOSE DATABASES ALL 
CLEAR ALL
*--------------------------------------------------------------------------------------