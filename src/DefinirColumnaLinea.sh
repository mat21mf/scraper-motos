  #### - Incorporar en:
  ####   ruta_relativa
  ####   para que se genere la columna linea
  #### - Revisar cada bot para colectar los nombres de las lineas si las hay
  #### - Plan A: asignar nombre de linea desde aqui.
  ####       - Bash: Muy dificil.
  ####       - R: Pendiente.
  ####       - Python: Pendiente.
  #### - Plan B: renombrar todos los archivos para que tengan el nombre
  ####   de la linea en vez del correlativo. Debe reflejarse desde bots.
  ####   Es mejor dejar los bots sencillos.

  # source "DefinirRutaProyecto.sh"
  # source "DefinirExtraccionMotos.sh"
  # source "EjecutarExtraccionMotos.sh"
  source "DefinirColumnaFecha.sh"
  source "EjecutarExtraccionYamaha.sh"

  #### Lineas por marca desde modulos python
  declare -A strfle

  strfle["flestr01"]="imoto"
  strfle["flestr02"]="suzuki"
  strfle["flestr03"]="yamaha"
  strfle["flestr04"]="euromot"
  strfle["flestr05"]="honda"
  strfle["flestr06"]="zongshen"
  strfle["flestr07"]="kymco"
  strfle["flestr08"]="gildemeister"
  strfle["flestr09"]="benelli"
  strfle["flestr10"]="keeway"
  strfle["flestr11"]="linhai"
  strfle["flestr12"]="motossym"

  declare -A arrlin

  arrlin["flestr01_00"]="TM-Racing"
  arrlin["flestr01_01"]="ATV"
  arrlin["flestr01_02"]="Calle"
  arrlin["flestr01_03"]="Scooter"
  arrlin["flestr01_04"]="Cross"
  arrlin["flestr01_05"]="Dual"
  arrlin["flestr01_06"]="Trabajo"
  arrlin["flestr01_07"]="Semi-Nuevas"
  arrlin["flestr01_08"]="Sport"
  arrlin["flestr02_00"]="Calle"
  arrlin["flestr02_01"]="Scooter"
  arrlin["flestr02_02"]="Deportiva"
  arrlin["flestr02_03"]="Multiproposito"
  arrlin["flestr02_04"]="Custom-Retro"
  arrlin["flestr02_05"]="Motocross"
  arrlin["flestr02_06"]="Enduro"
  arrlin["flestr02_07"]="Infantil"
  arrlin["flestr02_08"]="ATV"
  arrlin["flestr03_00"]="Motos"
  arrlin["flestr03_01"]="ATV"
  arrlin["flestr03_02"]="UTV"
  arrlin["flestr03_03"]="Nautica"
  arrlin["flestr04_00"]="urbanas"
  arrlin["flestr04_01"]="estilo-custom"
  arrlin["flestr04_02"]="doble-proposito"
  arrlin["flestr05_00"]="ciudad"
  arrlin["flestr05_01"]="naked"
  arrlin["flestr05_02"]="scooter"
  arrlin["flestr05_03"]="adventure"
  arrlin["flestr05_04"]="deportiva"
  arrlin["flestr05_05"]="touring"
  arrlin["flestr05_06"]="competicion"
  arrlin["flestr05_07"]="atv"
  arrlin["flestr06_00"]="Scooter"
  arrlin["flestr06_01"]="Custom"
  arrlin["flestr06_02"]="Calle"
  arrlin["flestr06_03"]="Multiproposito"
  arrlin["flestr07_00"]="SCOOTER"
  arrlin["flestr07_01"]="ATV"
  arrlin["flestr09_00"]="NAKED"
  arrlin["flestr09_01"]="SPORT"
  arrlin["flestr09_02"]="TOURING"
  arrlin["flestr09_03"]="SCRAMBLER"
  arrlin["flestr10_00"]="linea-custom"
  arrlin["flestr10_01"]="linea-rk"
  arrlin["flestr10_02"]="linea-urban"
  arrlin["flestr10_03"]="linea-atv"
  arrlin["flestr11_00"]="atv150"
  arrlin["flestr11_01"]="atv260"
  arrlin["flestr11_02"]="atv500"
  arrlin["flestr11_03"]="atv700"
  arrlin["flestr11_04"]="atvm150"
  arrlin["flestr11_05"]="utv400"
  arrlin["flestr11_06"]="utv800"
  arrlin["flestr11_07"]="m550"
  arrlin["flestr12_00"]="Scooter"
  arrlin["flestr12_01"]="ATV"
  arrlin["flestr12_02"]="Moto"

# declare -A continent
#
# continent[Vietnam]=Asia
# continent[Germany]=Europe
# continent[Argentina]=America
#
# for c in "${!continent[@]}"; do
#     printf "%s is in %s\n" "$c" "${continent[$c]}"
#     echo ${continent[Vietnam]}
#     eval echo \${continent[Asia]}
# done

  #### Estas dos funciones van por un lado. OK, solo echo
  declare -x IncrementadorArreglo01=$( \
  for arrinc in "${!arrlin[@]}" ; do
    printf "echo %s\|\"%s\"\n" "${arrlin[$arrinc]}" "$arrinc"
  done \
    | sort \
    )
 #echo    "${IncrementadorArreglo01}"

  #### OK, solo echo
  declare -x IncrementadorArreglo02=$( \
  bash -c "${IncrementadorArreglo01}" \
    | sed -r 's/(.*)\|(.*)/\2 \1/' \
    | sed -r 's/(.*)flestr01/\1imoto/' \
    | sed -r 's/(.*)flestr02/\1suzuki/' \
    | sed -r 's/(.*)flestr03/\1yamaha/' \
    | sed -r 's/(.*)flestr04/\1euromot/' \
    | sed -r 's/(.*)flestr05/\1honda/' \
    | sed -r 's/(.*)flestr06/\1zongshen/' \
    | sed -r 's/(.*)flestr07/\1kymco/' \
    | sed -r 's/(.*)flestr08/\1gildemeister/' \
    | sed -r 's/(.*)flestr09/\1benelli/' \
    | sed -r 's/(.*)flestr10/\1keeway/' \
    | sed -r 's/(.*)flestr11/\1linhai/' \
    | sed -r 's/(.*)flestr12/\1motossym/' \
    | sort \
    )
 #echo    "${IncrementadorArreglo02}"

  ## #### Innecesario, reemplazado por anterior modulo {{{
  ##  declare -x PrintIncrementArreglo02=$( \
  ##  echo    "${IncrementadorArreglo02}" \
  ##    | gawk -F' ' '{if($1==old)
  ##            {offset++;printf("%s_%02d %s\n", $1, offset, $2)}
  ##            else
  ##            {offset=0;printf("%s_%02d %s\n", $1, offset, $2)};old=$1}' \
  ##    )
  ## #echo    "${PrintIncrementArreglo02}"
  ## #### }}}

  function ObtenerIncrementador01 () {

    echo    "${IncrementadorArreglo02}" \
      | grep -i --color "${1}" \
      | sed -r 's/(.*) (.*)/\2/' \

  }

  export -f ObtenerIncrementador01

 #ObtenerIncrementador01 "imoto_00"

  #### Corregido lo anterior para usar este modulo OK {{{
  declare -x TestearAdicionarLinea01=$( \
    echo "${ImprimirExtraccionMotos01}" \
    | gawk '{if($0 !~ /honda_02_01/) {print $0}}' \
    | gawk '{if($0 !~ /honda_02_02/) {print $0}}' \
    | grep -v 'honda\|yamaha\|Trabajo' \
    | head -n 2 \
    | sed -r 's/(.*) (.*) (.*)\/([a-z]+)_([0-9]{2})_(.*)\.(.*) ;/paste <(\1 \2 \3\/\4_\5_\6\.\7 ) <(  ObtenerIncrementador01 \"\4_\5\" )/' \
    )
 #echo    "${TestearAdicionarLinea01}"
  #### }}}

  #### Ejecutar despues de AdicionarFecha. OK. Definitivo. {{{
  declare -x TestearAdicionarLinea02=$( \
    echo "${ImprimirExtraccionMotos02}" \
    | gawk '{if($0 !~ /honda_02_01/) {print $0}}' \
    | gawk '{if($0 !~ /honda_02_02/) {print $0}}' \
    | grep -i 'yamaha' \
    | grep -v 'honda' \
    | sed -r '/yamaha/!s/(.*) (.*) (.*)\/([a-z]+)_([0-9]{2})_(.*)\.(.*) ;/paste <(\1 \2 \3\/\4_\5_\6\.\7 ) <( echo \"\4_\5_\6\" | gawk -F'\''_'\'' '\''{print $4, $5, $6}'\'' OFS='\''_'\'') <(  ObtenerIncrementador01 \"\4_\5\" )/
              /yamaha/s/(.*) (.*) (.*)\/([a-z]+)_([0-9]{2})_(.*)\.(.*) ;/paste <(\1 \2 \3\/\4_\5_\6\.\7 ) <( \1 \3\/\4_\5_\6\.\7 ) <( echo \"\4_\5_\6\" | gawk -F'\''_'\'' '\''{print $4, $5, $6}'\'' OFS='\''_'\'') <(  ObtenerIncrementador01 \"\4_\5\" )/' \
    | sed -r '/yamaha/s/(.*)\.html/\1\.json/;/yamaha/s/(.*)htmdir/\1jsndir/;/yamaha/s/(.*)ExtraccionMotos/\1LlamarYamaha/' \
    )
  echo    "${TestearAdicionarLinea02}"
 #bash -c "${TestearAdicionarLinea02}"
  #### }}}

  #### Evaluar Adicionar Linea. Modo echo. OK.
  declare -x EvaluarAdicionarLinea01=$( \
  bash -c "${TestearAdicionarLinea01}" \
    | sed -r 's/\t/|/g' \
    | gawk -F'|' '{for(i=1;i<NR;i++) ; if($6!="") {tit=$6;print $1,$2,$3,$4,$5,"linea"} else {print $1,$2,$3,$4,$5,tit}}' OFS='|' \
    )
 #echo    "${EvaluarAdicionarLinea01}"

  #### Ejecutar despues de AdicionarFecha. OK. Definitivo.
  declare -x EvaluarAdicionarLinea02=$( \
  bash -c "${TestearAdicionarLinea02}" \
    | sed -r 's/^ +//g;s/^\t+//g' \
    | grep -v 'honda\|yamaha' \
    | sed -r 's/\t/|/g' \
    | gawk -F'|' '{for(i=1;i<NR;i++) ; if($6!="") {fec=$6;lin=$7;print $1,$2,$3,$4,$5,"fecha","linea"} else {print $1,$2,$3,$4,$5,fec,lin}}' OFS='|' \
    )
 #echo    "${EvaluarAdicionarLinea02}"

  #### Impresión sin cabeceras intermedias. OK.
  declare -x EvaluarExtraccionMotos02=$( \
  echo "${EvaluarAdicionarLinea02}" \
    | gawk '{if($0 !~ /honda_02_01/) {print $0}}' \
    | gawk '{if($0 !~ /honda_02_02/) {print $0}}' \
    | grep -v 'honda\|Trabajo' \
    | gawk -F'|' 'NR==1 {print}
                  NR>=2 && !/marca/ {print}' \
    )
 #echo  "${EvaluarExtraccionMotos02}"
 #echo  "${EvaluarExtraccionMotos02}" > "$csvdir/$fleout"

  declare -x ReordenarExtraccionMotos02=$( \
    echo "${EvaluarExtraccionMotos02}" \
    | gawk -F'|' '{print $1,$2,$4,$3,$5,$6,$7}' OFS='|' \
    ) 

  #### Corregido y definitivo
# echo    "${ReordenarExtraccionMotos02}"
 #echo    "${ReordenarExtraccionMotos02}" > "$csvdir/$fleout"

  #### ====================
  #### No usar lo siguiente
  #### ====================

  #### Verificaciones opcionales
  function ListarLineasPorMarca () {

    varfle=$(basename "${1}" .html)
    varfch=$(echo "${varfle}" \
    | gawk -F'_' '{print $0}')
    echo "${varfch}"

  }

  export -f ListarLineasPorMarca

  declare -x VerificarLineasPorMarca=$(find $htmdir -maxdepth 1 -type f \
    | sort \
    | sed -r 's/(.*)\/(.*)/  ListarLineasPorMarca \"$htmdir\/\2\" ;/' \
    | sed -r '$s/ ;/\) \\/
              1i \\ ( \\' \
    | sed -r '$a \\  \| sort \| uniq \\
              $a \\  \| gawk -F'\''_'\'' '\''{if(NF>=3) {print $1"_"$2}}'\'' \\
              $a \\  \| sort \| uniq \\
              $a \\  \| gawk -F'\''_'\'' '\''{print $1}'\'' \\
              $a \\  \| sort \| uniq -c' \
    )

 #echo    "${VerificarLineasPorMarca}"
 #bash -c "${VerificarLineasPorMarca}"
