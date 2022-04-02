 #!/bin/bash
 
 # Script para identificar equipos vivos por ping sweep, los que estuvieron en el stream del 30 de Marzo deben de adicionar y crear
 # uno que identifique hosts vivos y que no lo esten por medio de un if, y ademas implementar el mismo a su manera u otra forma de hacerlo. 
 #
 
 echo "IDENTIFICANDO HOSTS VIVOS EN LA RED POR PING"
 # seq 1 255
for i in `seq 1 255`; do ping -c 1 $1.$i | grep "64 bytes" | awk -F " " '{print $4  " -> LIVE"}' | tr -d ":" >> LIVE.hosts & done
