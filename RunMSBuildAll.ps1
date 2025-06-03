git branch --format='%(refname:short)'
    | ForEach-Object { git checkout $_ ; msbuild -restore ; Write-Host }
git checkout main
