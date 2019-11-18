$EnvName = 'helloword-dev' 
$ResourceGroupName = $EnvName + '-rg'   
#$KeyVaultName = $EnvName + "-kv"
$Location = 'eastus'
$Environment = 'dev'

$TemplateFile = 'https://raw.githubusercontent.com/Atlchris67/linkedArmTemplates/master/helloworldparent.json'
#$TemplateParameterFile = 'C:\devroot\improving\cu-direct\rg-as-parts\keyvault\parameters.json'


Get-AzContext
#cat $TemplateParameterFile 
#cat $TemplateFile

try{
    Get-AzResourceGroup -Name $ResourceGroupName -Location $Location -ErrorAction Stop
    Get-AzResource | Where-Object{$_.ResourceGroupName -eq "$ResourceGroupName"} | Select-Object -Property Name
}
catch{
    New-AzResourceGroup -Name $ResourceGroupName -Location $Location
}



#$ParametesFilesPath = "C:\devroot\improving\cu-direct\rg-as-parts\"

#$paramFiles = Get-ChildItem -Path $ParameteFilePath -Force -Recurse -Include *.parameters.json

#$paramFiles | ForEach-Object -Process {

    $TemplateParams = @{
        ResourceGroupName = $ResourceGroupName  
        TemplateUri = $TemplateFile
        #TemplateFile = $_.Directory.FullName + "\" + $_.Name.Substring( 0,$_.Name.IndexOf('.') ) + ".json"
        #TemplateParameterFile = $_.FullName
    }

    New-AzResourceGroupDeployment @TemplateParams

#}


