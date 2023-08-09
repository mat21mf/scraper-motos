  source "DefinirRutaProyecto.sh"
  source "DefinirExtraccionYamaha.sh"

  function LlamarYamaha () {

    declare -x EjecutarYamahaAnidado=$(
    lon=$(cat "${1}" | jq 'length/2' | sed -r 's/ //g')
    inc=0
    while [ $inc -lt $lon ] ; do
      sum=$(expr $inc + $lon)
      echo   DefinirYamaha "${1}" $inc $sum
      let inc=inc+1
    done \
      | sed -r 's/$/ ;/
                $s/ ;/ \) \\/
                1 i\\( \\
                $ a\\| gawk -F'\''|'\'' '\''NR==1 {print} NR>=2 \&\& !\/marca\/ {print}'\''
                ' \
      )
    declare -x ReordenarYamahaAnidado=$( \
    bash -c "${EjecutarYamahaAnidado}" \
    | gawk -F'\t' '{print $1,$2,$4,$3,$5}' OFS='|' \
    )
    echo    "${ReordenarYamahaAnidado}"

  }

  export -f LlamarYamaha

  ImprimirExtraccionYamaha00=$( \
  find $jsndir -type f \
    | sed -r 's/(.*)\/(.*)/LlamarYamaha \$jsndir\/\2 ;/' \
    )

  ImprimirExtraccionYamaha01=$( \
  find $jsndir -type f \
    | sed -r 's/(.*)\/(.*)/LlamarYamaha \$jsndir\/\2 ;/' \
    )

 #echo    "${ImprimirExtraccionYamaha01}"

  EvaluarExtraccionYamaha01=$( \
  echo "${ImprimirExtraccionYamaha01}" \
    | sed -r '1i \\( \\' \
    | sed -r '$s/;/\) \\/' \
    | sed -r '$a \\  | gawk -F'\''|'\'' '\''NR==1 {print} NR>=2 \&\& !\/marca\/ {print}'\''' \
    )

 #echo    "${EvaluarExtraccionYamaha01}"
 #bash -c "${EvaluarExtraccionYamaha01}"

  declare -x ReordenarExtraccionYamaha01=$( \
    bash -c "${EvaluarExtraccionYamaha01}" \
    | gawk -F'\t' '{print $1,$2,$4,$3,$5}' OFS='|' \
    )

  #### Corregido y definitivo
 #echo    "${ReordenarExtraccionYamaha01}"

 #  lon=$(cat $jsndir/yamaha_00_00_2018_03_25.json | jq 'length/2' | sed -r 's/ //g')
 #     inc=0
 #  while [ $inc -lt $lon ] ; do
 #    sum=$(expr $inc + $lon)
 #    echo   DefinirYamaha $jsndir/yamaha_00_00_2018_03_25.json $inc $sum
 #    let inc=inc+1
 #  done
