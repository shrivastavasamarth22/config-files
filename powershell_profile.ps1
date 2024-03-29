# Prompts
oh-my-posh init pwsh | Invoke-Expression

oh-my-posh init pwsh --config 'C:\Users\shriv\AppData\Local\Programs\oh-my-posh\themes\pure.omp.json' | Invoke-Expression

# Icons
Import-Module Terminal-Icons

# PSReadLine
Set-PsReadLineOption -PredictionSource History
Set-PsReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar


#Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PsReadlineChordReverseHistory 'Ctrl+r'

function Get-AllItems {
  Get-ChildItem -Force
}

# Alias
Set-Alias vim nvim
Set-Alias g git
Set-Alias which gcm
Set-Alias ll Get-AllItems
Set-Alias grep findstr
Set-Alias touch ni
Set-Alias cat gc
