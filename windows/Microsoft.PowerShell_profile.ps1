# Aliases
Set-Alias g git
Set-Alias ln New-SymLink

# Aliases that cannot be done with Set-Alias
function la() {
	Get-ChildItem -force | Select-Object Mode, LastWriteTime, @{Name="Size";Expression={Format-FileSize($_.Length)}}, Name
}
function l() {
	Get-ChildItem | Select-Object Mode, LastWriteTime, @{Name="Size";Expression={Format-FileSize($_.Length)}}, Name
}
function ..() { cd .. }
function mkdirp($path) {
	New-Item -Force -Type directory -Path $path
}
function reload() { . $PROFILE }

# Vagrant aliases
function vs() { vagrant status }
function vup() { vagrant up }
function vh() { vagrant halt }
function vsus() { vagrant suspend }
function vres() { vagrant resume }
function vr() { vagrant reload }
function vssh() { vagrant ssh }
function vp() { vagrant provision }
function vd() { vagrant destroy }
function vdd() { vagrant destroy -f }

# Other functions
Function Format-FileSize() {
    Param ([int]$size)
    If     ($size -gt 1TB) {[string]::Format("{0:0.00} TB", $size / 1TB)}
    ElseIf ($size -gt 1GB) {[string]::Format("{0:0.00} GB", $size / 1GB)}
    ElseIf ($size -gt 1MB) {[string]::Format("{0:0.00} MB", $size / 1MB)}
    ElseIf ($size -gt 1KB) {[string]::Format("{0:0.00} kB", $size / 1KB)}
    ElseIf ($size -gt 0)   {[string]::Format("{0:0.00} B", $size)}
    Else                   {""}
}
Function New-SymLink ($target, $link)
{
    if (test-path -pathtype container $target)
    {
        $command = "cmd /c mklink /d"
    }
    else
    {
        $command = "cmd /c mklink"
    }

    invoke-expression "$command $link $target"
}

# Load posh-git example profile
function loadPoshGit() {
	$path = "$(Split-Path -parent $PROFILE)\posh-git\profile.example.ps1"
	If (Test-Path $path){
		. $path
	}
}
loadPoshGit
