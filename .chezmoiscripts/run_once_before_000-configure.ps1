$ErrorActionPreference = "Stop"

scoop alias add upgrade 'scoop update *' 'Updates all apps, just like brew or apt'

scoop add bucket artifacthub
scoop add bucket extras
scoop add bucket java
scoop add bucket nerd-fonts
