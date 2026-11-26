
need to learn more berfore doing #v2

<#Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form

$form.Text = "System Monitor"
$form.Size = [System.Drawing.Size]::new(1100, 700)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(18, 18, 24)
$form.ForeColor = [System.Drawing.Color]::White
$form.FormBorderStyle = "Sizable"
$sidebar = New-Object System.Windows.Forms.Panel
$sidebar.Size = [System.Drawing.Size]::new(220, 700)
$sidebar.Dock = "Left"
$sidebar.BackColor = [System.Drawing.Color]::FromArgb(25, 25, 33)

$form.Controls.Add($sidebar)

$logo = New-Object System.Windows.Forms.Label
$logo.Text = "SYSTEM MONITOR"
$logo.Location = [System.Drawing.Point]::new(20, 25)
$logo.Size = [System.Drawing.Size]::new(190, 40)
$logo.Font = [System.Drawing.Font]::new("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$logo.ForeColor = [System.Drawing.Color]::White

$sidebar.Controls.Add($logo)

$dashboard = New-Object System.Windows.Forms.Button
$dashboard.Text = "Dashboard"
$dashboard.Location = [System.Drawing.Point]::new(15, 100)
$dashboard.Size = [System.Drawing.Size]::new(190, 45)
$dashboard.FlatStyle = "Flat"
$dashboard.FlatAppearance.BorderSize = 0
$dashboard.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 60)
$dashboard.ForeColor = [System.Drawing.Color]::White

$sidebar.Controls.Add($dashboard)

$title = New-Object System.Windows.Forms.Label
$title.Text = "System Overview"
$title.Location = [System.Drawing.Point]::new(255, 35)
$title.Size = [System.Drawing.Size]::new(500, 45)
$title.Font = [System.Drawing.Font]::new("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
$title.ForeColor = [System.Drawing.Color]::White

$form.Controls.Add($title)

[void]$form.ShowDialog() #>