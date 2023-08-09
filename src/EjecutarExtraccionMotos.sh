
  source "DefinirRutaProyecto.sh"
  source "DefinirExtraccionMotos.sh"

  strfle01="imoto"
  strfle02="suzuki"
  strfle03="yamaha"
  strfle04="euromot"
  strfle05="honda"
  strfle06="zongshen"
  strfle07="kymco"
  strfle08="gildemeister"
  strfle09="benelli"
  strfle10="keeway"
  strfle11="linhai"
  strfle12="motossym"

    fchfle=$(date \
      | gawk -F' ' '{print $6"_"$2"_"$3}' \
      | sed -r 's/ene/01/
                s/feb/02/
                s/mar/03/
                s/abr/04/
                s/may/05/
                s/jun/06/
                s/jul/07/
                s/ago/08/
                s/sep/09/
                s/oct/10/
                s/nov/11/
                s/dic/12/' \
      )

  #### Listar todas extracciones
  declare -x ListarTodosReg=$(find $htmdir -type f)
  #### Listar recientes vs historicas, version obsoleta
  declare -x ListarAnterior=$(find $htmdir -type f | grep -v "${fchfle}")
  declare -x ListarActuales=$(find $htmdir -type f | grep -i "${fchfle}")
  #### Listar recientes vs historicas, version definitiva
  declare -x ListarTesteo01="2018_04_22"
  declare -x ListarReciente=$(find $htmdir -type f | gawk -F'_' '{print $4"_"$5"_"$6}' \
    | sort | uniq | sed -r 's/\.html//' | tail -n 1 \
    )
  declare -x ListarHistoric=$(find $htmdir -type f | gawk -F'_' '{print $4"_"$5"_"$6}' \
    | sort | uniq | sed -r 's/\.html//' | sed -r '$d' | paste -s -d'|' | sed -r 's/\|/\\|/g' \
    )

  #### Usar para carga inicial
  declare -x ImprimirExtraccionMotos00=$( echo "${ListarTodosReg}" \
      | sort \
    | sed -r 's/(.*)\/'"${strfle01}"'(.*)/  ExtraccionMotos  1 \"$htmdir\/'"${strfle01}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle02}"'(.*)/  ExtraccionMotos  2 \"$htmdir\/'"${strfle02}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle03}"'(.*)/  ExtraccionMotos  3 \"$htmdir\/'"${strfle03}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle04}"'(.*)/  ExtraccionMotos  4 \"$htmdir\/'"${strfle04}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle05}"'(.*)/  ExtraccionMotos  5 \"$htmdir\/'"${strfle05}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle06}"'(.*)/  ExtraccionMotos  6 \"$htmdir\/'"${strfle06}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle07}"'(.*)/  ExtraccionMotos  7 \"$htmdir\/'"${strfle07}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle08}"'(.*)/  ExtraccionMotos  8 \"$htmdir\/'"${strfle08}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle09}"'(.*)/  ExtraccionMotos  9 \"$htmdir\/'"${strfle09}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle10}"'(.*)/  ExtraccionMotos 10 \"$htmdir\/'"${strfle10}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle11}"'(.*)/  ExtraccionMotos 11 \"$htmdir\/'"${strfle11}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle12}"'(.*)/  ExtraccionMotos 12 \"$htmdir\/'"${strfle12}"'\2\" ;/' \
    | sort -n -k2 \
    )
 #echo "${ImprimirExtraccionMotos00}"

  declare -x ImprimirExtraccionMotos01=$( echo "${ListarTodosReg}" \
    | grep -i "${ListarHistoric}" \
    | sort \
    | sed -r 's/(.*)\/'"${strfle01}"'(.*)/  ExtraccionMotos  1 \"$htmdir\/'"${strfle01}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle02}"'(.*)/  ExtraccionMotos  2 \"$htmdir\/'"${strfle02}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle03}"'(.*)/  ExtraccionMotos  3 \"$htmdir\/'"${strfle03}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle04}"'(.*)/  ExtraccionMotos  4 \"$htmdir\/'"${strfle04}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle05}"'(.*)/  ExtraccionMotos  5 \"$htmdir\/'"${strfle05}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle06}"'(.*)/  ExtraccionMotos  6 \"$htmdir\/'"${strfle06}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle07}"'(.*)/  ExtraccionMotos  7 \"$htmdir\/'"${strfle07}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle08}"'(.*)/  ExtraccionMotos  8 \"$htmdir\/'"${strfle08}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle09}"'(.*)/  ExtraccionMotos  9 \"$htmdir\/'"${strfle09}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle10}"'(.*)/  ExtraccionMotos 10 \"$htmdir\/'"${strfle10}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle11}"'(.*)/  ExtraccionMotos 11 \"$htmdir\/'"${strfle11}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle12}"'(.*)/  ExtraccionMotos 12 \"$htmdir\/'"${strfle12}"'\2\" ;/' \
    | sort -n -k2 \
    )
 #echo "${ImprimirExtraccionMotos01}"

  #### Usar para demo o para actualizaciones
  declare -x ImprimirExtraccionMotos02=$( echo "${ListarTodosReg}" \
    | grep -i "${ListarReciente}" \
    | sort \
    | sed -r 's/(.*)\/'"${strfle01}"'(.*)/  ExtraccionMotos  1 \"$htmdir\/'"${strfle01}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle02}"'(.*)/  ExtraccionMotos  2 \"$htmdir\/'"${strfle02}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle03}"'(.*)/  ExtraccionMotos  3 \"$htmdir\/'"${strfle03}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle04}"'(.*)/  ExtraccionMotos  4 \"$htmdir\/'"${strfle04}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle05}"'(.*)/  ExtraccionMotos  5 \"$htmdir\/'"${strfle05}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle06}"'(.*)/  ExtraccionMotos  6 \"$htmdir\/'"${strfle06}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle07}"'(.*)/  ExtraccionMotos  7 \"$htmdir\/'"${strfle07}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle08}"'(.*)/  ExtraccionMotos  8 \"$htmdir\/'"${strfle08}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle09}"'(.*)/  ExtraccionMotos  9 \"$htmdir\/'"${strfle09}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle10}"'(.*)/  ExtraccionMotos 10 \"$htmdir\/'"${strfle10}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle11}"'(.*)/  ExtraccionMotos 11 \"$htmdir\/'"${strfle11}"'\2\" ;/' \
    | sed -r 's/(.*)\/'"${strfle12}"'(.*)/  ExtraccionMotos 12 \"$htmdir\/'"${strfle12}"'\2\" ;/' \
    | sort -n -k2 \
    )
 #echo "${ImprimirExtraccionMotos02}"

  declare -x EvaluarExtraccionMotos00=$(echo "${ImprimirExtraccionMotos00}" \
    | gawk '{if($0 !~ /honda_02_01/) {print $0}}' \
    | gawk '{if($0 !~ /honda_02_02/) {print $0}}' \
    | grep -v 'honda\|Trabajo' \
    | sed -r '$s/ ;/\) \\/
              1i \\ ( \\' \
    | sed -r '$a \\  | gawk -F'\''|'\'' '\''NR==1 {print}
              $a \\                NR>=2 && !/marca/ {print}'\''' \
    )

  #### =======================
  #### Verificaciones calculos
  #### =======================

  declare -x VerificarCalculoBono00=$(echo "${EvaluarExtraccionMotos01}" \
    | sed -r '$s/$/ \\/
              $a \\  | gawk -F'\''|'\'' '\''NR==1 {print $0, "Verif00"}
              $a \\          NR>1 {if($3!="")
              $a \\          {print $0, "POSICION CORRECTA"}
              $a \\          else
              $a \\          {print $0, "POSICION INCORRECTA"}}'\'' OFS='\''|'\''')

  declare -x VerificarCalculoBono01=$(echo "${EvaluarExtraccionMotos01}" \
    | sed -r '$s/$/ \\/
              $a \\  | gawk -F'\''|'\'' '\''NR==1 {print $0, "Verif01"}
              $a \\          NR>1 {if(($3!="") && ($4!="") && ($5!=""))
              $a \\          {if($3-$4==$5)
              $a \\          {print $0, "RELACION CORRECTA"}
              $a \\          else
              $a \\          {print $0, "RELACION INCORRECTA"}}}'\'' OFS='\''|'\''')

  declare -x VerificarCalculoBono02=$(echo "${EvaluarExtraccionMotos01}" \
    | sed -r '$s/$/ \\/
              $a \\  | gawk -F'\''|'\'' '\''NR==1 {print $0, "Verif02"}
              $a \\          NR>1 {if(($3!="") && ($4!="") && ($5==""))
              $a \\          {if($3>$4)
              $a \\          {print $0, "CALCULO CORRECTO"}
              $a \\          else
              $a \\          {print $0, "CALCULO INCORRECTO"}}}'\'' OFS='\''|'\''')

# echo    "${ImprimirExtraccionMotos01}"
# bash -c "${EvaluarExtraccionMotos01}"
# bash -c "${VerificarCalculoBono00}"
# bash -c "${VerificarCalculoBono01}"
# bash -c "${VerificarCalculoBono02}"

