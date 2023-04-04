$ErrorActionPreference = "Stop"

scoop alias add upgrade 'scoop update *' 'Updates all apps, just like brew or apt'

scoop bucket add artifacthub
scoop bucket add extras
scoop bucket add java
scoop bucket add nerd-fonts
