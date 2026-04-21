# Functions
function za { zellij attach; if ($LastExitCode -ne 0) { zellij } }
function g { git @args }
function gr { go run . @args }
function gt { go test ./... @args }
function gfmt { golangci-lint --fix @args }
