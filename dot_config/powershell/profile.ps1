$profileDir = $PSScriptRoot

$profileParts = @(
  'env.ps1'
  'aliases.ps1'
  'functions.ps1'
  'completions.ps1'
  'init.ps1'
)

foreach ($part in $profileParts) {
  $partPath = Join-Path -Path $profileDir -ChildPath $part
  if (Test-Path -Path $partPath -PathType Leaf) {
    . $partPath
  }
}
