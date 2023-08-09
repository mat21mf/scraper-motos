  #### - Incorporar en:
  ####   $HOME/Documents/TrabajosExtra/ivan/src/DefinirExtraccionMotos.sh
  ####   para que se genere la columna fecha
  #### - Usar funcion stat en vez de ls para agregar año automaticamente

  # source "DefinirRutaProyecto.sh"
  # source "DefinirExtraccionMotos.sh"
  source "EjecutarExtraccionMotos.sh"

  function NormalizarFechaArchivo () {

    varfle=$(basename "${1}" ".${3}")
    varfch=$(ls -l "${1}" \
      | gawk -F' ' '{printf "%s %02d\n", $6, $7}' \
      | sed -r 's/ene /01_/
                s/feb /02_/
                s/mar /03_/
                s/abr /04_/
                s/may /05_/
                s/jun /06_/
                s/jul /07_/
                s/ago /08_/
                s/sep /09_/
                s/oct /10_/
                s/nov /11_/
                s/dic /12_/
                s/^/2018_/')
    ClausulaRenombrar=$(echo "mv ${varfle}.${3} ${varfle}_${varfch}.${3}" \
      | sed -r 's/(.*) (.*) (.*)/\1 $'"${2}"'\/\2 $'"${2}"'\/\3/')
    bash -c "${ClausulaRenombrar}"

  }

  export -f NormalizarFechaArchivo

  function CrearArchivoFechaActual () {

    fmdt=$(date | gawk '{print NF}')

    if [[ $fmdt == 6 ]] ; then

    fchfle=$(date \
      | gawk -F' ' '{print $6"_"$2"_"$3}' \
      | sed -r -e 's/ene/01/;s/jan/01/
                   s/feb/02/;s/feb/02/
                   s/mar/03/;s/mar/03/
                   s/abr/04/;s/apr/04/
                   s/may/05/;s/may/05/
                   s/jun/06/;s/jun/06/
                   s/jul/07/;s/jul/07/
                   s/ago/08/;s/aug/08/
                   s/sep/09/;s/sep/09/
                   s/oct/10/;s/oct/10/
                   s/nov/11/;s/nov/11/
                   s/dic/12/;s/dec/12/' \
      )

    fi
    if [[ $fmdt == 7 ]] ; then

    fchfle=$(date \
      | gawk -F' ' '{print $6"_"$4"_"$2}' \
      | sed -r -e 's/ene/01/;s/jan/01/
                   s/feb/02/;s/feb/02/
                   s/mar/03/;s/mar/03/
                   s/abr/04/;s/apr/04/
                   s/may/05/;s/may/05/
                   s/jun/06/;s/jun/06/
                   s/jul/07/;s/jul/07/
                   s/ago/08/;s/aug/08/
                   s/sep/09/;s/sep/09/
                   s/oct/10/;s/oct/10/
                   s/nov/11/;s/nov/11/
                   s/dic/12/;s/dec/12/' \
      )

    fi

    outfle="Reporte_Precio_Motos_$fchfle.csv"

  }

  export -f CrearArchivoFechaActual

  CrearArchivoFechaActual
  declare -x flefch="${fchfle}"
  declare -x fleout="${outfle}"

 #function ListarArchivosActuales () {

 #  VarListarActual=$( \
 #  find "${1}" -type f \
 #    | grep -i --color "${fchfle}" \
 #    )

 #}

 #export -f ListarArchivosActuales

 #ListarArchivosActuales $csvdir
 #ListarArchivosActuales $htmdir
 #ListarArchivosActuales
 #declare -x VariableListarActual="${VarListarActual}"

  #### Renombrado 01
  declare -x EvaluarRenombrarFecha01=$(find $htmdir -maxdepth 1 -type f \
    | sort \
    | grep -v '2018' \
    | sed -r 's/(.*)\/(.*)/  NormalizarFechaArchivo \"$htmdir\/\2\" ;/')

  #### Renombrado 02
  declare -x EvaluarRenombrarFecha02=$(find $jsndir -maxdepth 1 -type f \
    | sort \
    | grep -v '2018' \
    | sed -r 's/(.*)\/(.*)/  NormalizarFechaArchivo \"$jsndir\/\2\" \"jsndir\" \"json\"/')

  #### ==================================
  #### Los siguientes modulos no dependen
  #### de la función normalizar fecha
  #### solo llaman ejecución extracción
  #### ==================================

  #### Preparar Adicionar Fecha OK
  declare -x TestearAdicionarFecha01=$(echo "${ImprimirExtraccionMotos01}" \
    | gawk '{if($0 !~ /honda_02_01/) {print $0}}' \
    | gawk '{if($0 !~ /honda_02_02/) {print $0}}' \
    | grep -v 'honda\|yamaha' \
    | head -n 2 \
    | sed -r 's/(.*) (.*) (.*)\/(.*)\.(.*) ;/paste <(\1 \2 \3\/\4\.\5 ) <( echo \"\4\" | gawk -F'\''_'\'' '\''{print $4, $5, $6}'\'' OFS='\''_'\'')/' \
    )

  #### Preparar Adicionar Fecha PENDIENTE yamaha y honda
  declare -x PrepararAdicionarFecha01=$(echo "${ImprimirExtraccionMotos01}" \
    | sed -r 's/(.*) (.*) (.*)\/(.*)\.(.*) ;/paste <(\1 \2 \3\/\4\.\5 ) <( echo \"\4\" | gawk -F'\''_'\'' '\''{print $4, $5, $6}'\'' OFS='\''_'\'')/' \
    )

  #### Evaluar Adicionar Fecha OK
  declare -x EvaluarAdicionarFecha01=$(bash -c "${TestearAdicionarFecha01}" \
    | sed -r 's/\t/|/g' \
    | gawk -F'|' '{for(i=1;i<NR;i++) ; if($6!="") {tit=$6;print $1,$2,$3,$4,$5,"fecha"} else {print $1,$2,$3,$4,$5,tit}}' OFS='|' \
    )

# bash -c "${EvaluarRenombrarFecha01}"
# bash -c "${EvaluarRenombrarFecha02}"
# bash -c "${PrepararAdicionarFecha01}"
# bash -c "${TestearAdicionarFecha01}"
# echo    "${EvaluarAdicionarFecha01}"
