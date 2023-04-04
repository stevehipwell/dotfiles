$ErrorActionPreference = "Stop"

scoop alias add upgrade 'scoop update *' 'Updates all apps, just like brew or apt'

scoop bucket add artifacthub https://github.com/artifacthub/scoop-cmd
scoop bucket add extras
scoop bucket add java
scoop bucket add nerd-fonts
