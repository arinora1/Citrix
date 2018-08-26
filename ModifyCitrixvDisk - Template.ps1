## Modify Citrix vDisk Script ##
## Enter your site name, store name and Collection Group names
## The script has assumed your collection group names are Production and Development
## These can be changed to suit your environment if required

Import-Module “C:\Program Files\Citrix\Provisioning Services Console\Citrix.PVS.SnapIn.dll”

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI{ 

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '400,245'
$Form.text                       = "Modify Citrix vDisk"
$Form.TopMost                    = $false

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "The purpose of this application is to simplify the process of"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(16,20)
$Label1.Font                     = 'Microsoft Sans Serif,10'

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "updating the Citrix PVS images used in the environment."
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(20,42)
$Label2.Font                     = 'Microsoft Sans Serif,10'

$ComboBox1                       = New-Object system.Windows.Forms.ComboBox
$ComboBox1.width                 = 148
$ComboBox1.height                = 20
@('Production','Development') | ForEach-Object {[void] $ComboBox1.Items.Add($_)}
$ComboBox1.location              = New-Object System.Drawing.Point(16,104)
$ComboBox1.Font                  = 'Microsoft Sans Serif,10'

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Collection"
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(16,82)
$Label3.Font                     = 'Microsoft Sans Serif,10'

$Label4                          = New-Object system.Windows.Forms.Label
$Label4.text                     = "Enter vDisk Name"
$Label4.AutoSize                 = $true
$Label4.width                    = 25
$Label4.height                   = 10
$Label4.location                 = New-Object System.Drawing.Point(16,142)
$Label4.Font                     = 'Microsoft Sans Serif,10'

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $false
$TextBox1.width                  = 352
$TextBox1.height                 = 20
$TextBox1.location               = New-Object System.Drawing.Point(16,165)
$TextBox1.Font                   = 'Microsoft Sans Serif,10'

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Modify"
$Button1.width                   = 60
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(17,197)
$Button1.Font                    = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($Label1,$Label2,$ComboBox1,$Label3,$Label4,$TextBox1,$Button1))

#region gui events {
$Button1.Add_Click({
    if (-not ($TextBox1.Text -eq "")) {
	    $Form.Close()
    } else {
     [System.Windows.MessageBox]::Show("Please enter a vDisk name","vDisk","Ok","Warning")
    }
})
#endregion events }

#endregion GUI }


#Write your logic code here

[void]$Form.ShowDialog()

$cmd = "Add-PvsDiskLocatorToDevice -SiteName `"SITENAME`" -StoreName `"STORE`" -DiskLocatorName `"$($TextBox1.Text)`" -CollectionName `"$($ComboBox1.SelectedItem)`" -RemoveExisting"

switch ($ComboBox1.SelectedItem) {

    "Production" { 
        Write-Host  $cmd
        break
    }

    "Development" { 
        Write-Host  $cmd
        break
    }

    default { 
        Write-host "Invalid Selection"
        exit
    }

}

Invoke-Expression $cmd
