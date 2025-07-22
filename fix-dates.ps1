$files = Get-ChildItem -Path "D:\Downloads\000000-Workshop (1)\000000-Workshop\000058-SessionManager\000058-SessionManager\content" -Recurse -Include "*.md"

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $newContent = $content -replace 'date\s*:\s*"`r Sys\.Date\(\)`"', 'date: "2023-07-15"'
    Set-Content -Path $file.FullName -Value $newContent
    Write-Host "Processed $($file.FullName)"
}

Write-Host "All files processed."