  ## 01: imoto
  ## 02: suzuki
  ## 03: yamaha
  ## 04: euromot
  ## 05: honda
  ## 06: zongshen
  ## 07: kymco
  ## 08: gildemeister (contiene tres siguientes)
  ## 09: benelli
  ## 10: keeway
  ## 11: linhai
  ## 12: motossym

  source "DefinirRutaProyecto.sh"

  function ExtraccionMotos () {

    #### imoto OK {{{
    if [[ "${1}" == 1 ]] ; then
      cat ${2} \
      | pup '#ProductBox > ul > li json{}' \
      | jq '.[] | {
        marca           : "imoto"                       ,
        modelo          : .children[2].children[0].text ,
        precio_lista    : .children[3].children[0].text ,
        precio_con_bono : .children[3].children[1].text ,
        valor_bono      : null
        }' \
      | jq '[.]' --compact-output \
      | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' \
      | sed -r 's/"//g
             2,$s/\$ +//g
             :a
             s/([0-9]+)\.([0-9]+)/\1\2/g
             ta'
    fi
    #### }}}
    #### suzuki OK REVISAR {{{
    if [[ "${1}" == 2 ]] ; then
      cat ${2} \
      | pup '#page > div > div > section.models-introduce > div.content > div > div > div.cols json{}' \
      | jq '
        if (.[].children[1].children[1] != null) then
        (
        (.[].children[].children[] |
         select( .name == "model" )         | .value ) as $modelo |
        (.[].children[].children[] |
         select( .name == "brand_vehicle" ) | .value ) as $marca  |
        (.[].children[].children[] |
         select( .name == "value_vehicle" ) | .value ) as $val_ve |
        (.[].children[].children[] |
         select( .name == "value_bono"    ) | .value ) as $val_bo |
        (.[].children[].children[] |
         select( .name == "value_total"   ) | .value ) as $val_to |
        (.[].children[1].children[1] |
         select( .class == "price"        ) | .text  ) as $val_ca |
        { marca           : $marca    ,
          modelo          : $modelo   ,
          precio_lista    : $val_ve   ,
          precio_con_bono : $val_to   ,
          valor_bono      : $val_bo   }
        )
        else
        (
        (.[].children[].children[] |
         select( .name == "model" )         | .value ) as $modelo |
        (.[].children[].children[] |
         select( .name == "brand_vehicle" ) | .value ) as $marca  |
        (.[].children[].children[] |
         select( .name == "value_vehicle" ) | .value ) as $val_ve |
        (.[].children[].children[] |
         select( .name == "value_bono"    ) | .value ) as $val_bo |
        (.[].children[].children[] |
         select( .name == "value_total"   ) | .value ) as $val_to |
        (.[].children[3].children[1] |
         select( .class == "price"        ) | .text  ) as $val_ca |
        { marca           : $marca    ,
          modelo          : $modelo   ,
          precio_lista    : $val_ve   ,
          precio_con_bono : $val_to   ,
          valor_bono      : $val_bo   }
        )
        end ' \
      | jq '[.]' --compact-output \
      | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' \
      | sed -r 's/"//g
                s/\$ //g
                :a
                s/([0-9])\.([0-9])/\1\2/g
                ta'
    fi
    #     valor_cae:      $val_ca   }
    #### }}}
    #### yamaha OK NORMALIZAR {{{
    if [[ "${1}" == 3 ]] ; then
      cat "${2}" \
        | pup '#top > ul > li > span json{}' \
        | jq '. |
          { marca           : "yamaha" ,
            modelo          : .[].text ,
            precio_lista    : .[].children[1].children[0].children[0].text ,
            precio_con_bono : .[].children[1].children[1].children[0].text ,
            valor_bono      : null
          }'


     ##### Version antigua no usar
     #jsnfle="${jsndir}/"$(basename "${2}" .html)".json"
     #cat "${2}" \
     #| pup "#content > ul > li > a" \
     #| pup "h3 , p json{}" \
     #> "${jsnfle}"
    fi
    #### }}}
    #### euromot OK {{{
    if [[ "${1}" == 4 ]] ; then
      # # Desde selenium
      # pup 'div > div.owl-carousel.owl-theme.owl-loaded.owl-responsive-1000 > div.owl-stage-outer > div > div.owl-item.active > div > div.col-50.fleft.ficha_tab01.animated.fadeInUp > div' | \
      # pup 'h1,h2 json{}' | \
        # Desde urllib2
      cat "${2}" \
      | pup 'h2 json{}' \
      | jq '. |
        if (.[1].children[1].children[0].text == null) then
        (
        {
        marca           : "euromot"             ,
        modelo          : .[2].text             ,
        precio_lista    : .[1].children[0].text ,
        precio_con_bono : null                  ,
        bono            : null
        }
        )
        else
        (
        {
        marca           : "euromot"                         ,
        modelo          : .[2].text                         ,
        precio_lista    : .[1].children[0].children[0].text ,
        precio_con_bono : .[1].children[1].children[0].text ,
        valor_bono      : null
        }
        )
        end ' \
      | jq '[.]' --compact-output \
      | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' \
      | sed -r 's/"//g
                :a
                s/([0-9])\.([0-9])/\1\2/g
                ta'
    fi
    #### }}}
    #### honda PENDIENTE {{{
    if [[ "${1}" == 5 ]] ; then
      cat "${2}" \
        | pup '#f_precios > div > div > div.f_precios_tabs' \
        | pup 'a > span json{}' \
        | jq '. | {
          marca              : "honda"    ,
          modelo             : .[0].text  ,
          precio_lista       : .[1].text  ,
          precio_con_bono    : .[2].text  ,
          valor_bono         : null       } , {
          marca              : "honda"    ,
          modelo             : .[5].text  ,
          precio_lista       : .[6].text  ,
          precio_con_bono    : .[7].text  ,
          valor_bono         : null       } , {
          marca              : "honda"    ,
          modelo             : .[10].text ,
          precio_lista       : .[11].text ,
          precio_con_bono    : .[12].text ,
          valor_bono         : null
          } ' \
        | jq '[.]' --compact-output \
        | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' \
        | sed -r 's/"//g
                  /honda\|\|\|/d
                  /Página oficial Moto 5/d
                  s/\|Precio con financiamiento Marubeni\|/|Precio Bono Marubeni: |/
                  s/\|Precio con Bono Marubeni:\|/|Precio Bono Marubeni: |/
                  s/\|Precio con Bono Marubeni\|/|Precio Bono Marubeni: |/
                  s/\|Precio Bono Marubeni\|/|Precio Bono Marubeni: |/
                  ' \
        | gawk -F'|' 'BEGIN{IGNORECASE=1}
                {if(($2~/precio bono marubeni: /))
                {$4=$2$3;$3="";$2="";print $0}
                else
                {print $0}}' OFS='|' \
        | sed -r 's/\|CB125F Twister BONO MARUBENI\|/|CB125F Twister Precio Bono Marubeni: |/
                  s/\|CB 190R Bono Marubeni\|/|CB 190R Precio Bono Marubeni: |/
                  s/\|CBR 250R Bono Marubeni\|/|CBR 250R Precio Bono Marubeni: |/
                 ' \
        | gawk -F'|' 'BEGIN{IGNORECASE=1}
                {if(($2~/marubeni/) && ($4==""))
                {$4="Precio Bono Marubeni: "$3;$3="";
                gsub(" Precio Bono Marubeni: ","",$2);
                print $0}
                else
                {print $0}}' OFS='|' \
        | gawk -F'|' 'BEGIN{IGNORECASE=1}
                {if(($2 ~ /bono marubeni/))
                {$3="";
                gsub(" Precio Bono Marubeni: ","",$2);
                print $0}
                else
                {print $0}}' OFS='|' \
        | gawk -F'|' 'BEGIN{IGNORECASE=1}
                {if(($2 ~ /bono/))
                {$4="Precio Bono Financiamiento: "$3;
                $3="";$2="";
                print $0}
                else
                {print $0}}' OFS='|' \
        | gawk -F'|' '{gsub("Precio Bono Marubeni: ","",$4);                 #### LIMPIEZA DE DESCRIPCION BONO
                       gsub("Precio Bono Financiamiento: ","",$4);           #### ============================
                       gsub("Precio Bono todo medio de pago: ","",$4);       #### Limpieza de precio con bono
                       gsub("Precio com Bono todo medio de pago: ","",$4);   #### una vez que se hizo la
                       gsub("Precio con Bono con medio de pago: ","",$4);    #### re ubicacion de los precios
                       gsub("Precio Bono con todo medio de pago: ","",$4);   #### en su respectiva columna
                       gsub("Precio con Bono todo medio de pago: ","",$4);   #### ============================
                       print $0}' OFS='|' \
        | gawk -F'|' 'BEGIN{IGNORECASE=1}
                       {gsub("Precio Lista: ","",$3);                        #### LIMPIEZA DESCRIPCION PRECIO LISTA
                       print $0}' OFS='|' \
        | sed -r 's/\$//g                                                    #### RETIRAR SIGNO PESO Y SEPARADOR MILES
                  :a
                  s/([0-9])\.([0-9])/\1\2/g
                  ta' \

      # | gawk -F'|' '{if(($3!="") && ($4!=""))                              #### VERIFICAR PRECIO LISTA MAYOR PRECIO CON BONO
      #               {if($3>$4)                                             #### ============================================
      #               {print $0, "OK"}
      #               else
      #               {print $0, "INCORRECTO"}}
      #               else
      #               {print $0}}' OFS='|' \

      # | gawk -F'|' '$4=="" {print}' \
      # | gawk -F'|' 'BEGIN{IGNORECASE=1} ($4 ~ /rojo/) {print $0}' \

        #### Revision de duplicado en color rojo y negro
        #### Definir un reemplazo solo para la primera ocurrencia --> negro
        #### Luego para la segunda ocurrencia                     --> rojo
        ####    gsub("NEGRO: ","Precio Bono Marubeni: ",$4);
        ####
#       | grep -i --color 'cb190r' \
#       | gawk '!r && /Precio Lista: ROJO: $1.890.000 - NEGRO: $1.890.000|Precio con Bono todo medio de pago: ROJO: $1.790.000 - NEGRO: $1.690.000/ {sub("Precio Lista: ROJO: $1.890.000 - NEGRO: $1.890.000|Precio con Bono todo medio de pago: ROJO: $1.790.000 - NEGRO: $1.690.000","Precio Lista: ROJO: $1.890.000|Precio con Bono todo medio de pago: ROJO: $1.790.000"); r=1}1' \
#       | sed -r '0,/Precio Lista: ROJO: \$1.890.000 - NEGRO: \$1.890.000\|Precio con Bono todo medio de pago: ROJO: \$1.790.000 - NEGRO: \$1.690.000/ s//Precio Lista: ROJO: \$1.890.000|Precio con Bono todo medio de pago: ROJO: \$1.790.000/
#                 '
#       | grep -i --color 'cb 190r' \
#       | grep -i --color 'rojo\|negro' \

      #### Otros testeos
      ####
      # | grep -i --color 'marubeni' \
      # | gawk -F'|' 'BEGIN{IGNORECASE=1}
      #         {if(($2 ~ /bono/) && ($4==""))
      #         {$4=$3;$3=$2;$2="";print $0}
      #         else {print $0}}' OFS='|' \
      # | gawk -F'|' 'BEGIN{IGNORECASE=1}
      #         {if(($4=="") && ($2 ~ /precio/))
      #         {$4=$3;$3=$2;$2="";print $0}
      #         else {print $0}}' OFS='|' \
      # | gawk -F'|' 'BEGIN{IGNORECASE=1} ($3 !~ /lista/) {print}' \
      # | gawk -F'|' '{if($2 ~ /Bono/) {$3=$2;$2="";print}'

      # | pup '#f_precios > div > h1' \
      # | jq 'length'

    fi
    #### }}}
    #### zongshen OK REVISAR {{{
    if [[ "${1}" == 6 ]] ; then
      cat "${2}" \
      | pup '#page > div > div > section.models-introduce > div.content > div > div' \
      | pup "div > div:nth-child(1), \
             div > div > div:nth-child(1), \
             div > div > div:nth-child(2) > div:nth-child(1), \
             div > div > div:nth-child(2) > div:nth-child(2) \
             json{}" \
      | jq '. | {
        marca           : "zongshen"            ,
        modelo          : .[0].children[0].text ,
        precio_lista    : .[1].children[1].text ,
        precio_con_bono : null                  ,
        valor_bono      : null
        } ' \
      | jq '[.]' --compact-output \
      | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' \
      | sed -r 's/"//g
                s/\$ //g
                :a
                s/([0-9])\.([0-9])/\1\2/g
                ta'
    fi
    #   valor_cae     : .[3].text
    #### }}}
    #### kymco OK REVISAR {{{
    if [[ "${1}" == 7 ]] ; then
      cat "${2}" \
      | pup '#page > div > div > section.models-introduce > div.content > div > div' \
      | pup "div > div:nth-child(1), \
             div > div > div:nth-child(1), \
             div > div > div:nth-child(2) > div:nth-child(1), \
             div > div > div:nth-child(2) > div:nth-child(2) \
             json{}" \
      | jq '. | {
        marca           : "kymco"               ,
        modelo          : .[0].children[0].text ,
        precio_lista    : .[1].children[1].text ,
        precio_con_bono : null                  ,
        valor_bono      : null
        } ' \
      | jq '[.]' --compact-output \
      | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' \
      | sed -r 's/"//g
                s/\$ //g
                :a
                s/([0-9])\.([0-9])/\1\2/g
                ta'
    fi
    #   valor_cae:     .[3].text
    #### }}}
    #### benelli OK {{{
    if [[ "${1}" == 9 ]] ; then
      cat "${2}" \
      | pup 'title:contains("Benelli") , #rmjs-1 text{}' \
      | grep -i --color 'benelli\|precio' \
      | iconv -f UTF-8 -t ISO-8859-1 \
      | head -n 2 \
      | sed -r 's/^ +//g
                1s/ - .*//g
                2s/(.*)(\$[0-9]+\.[0-9]+\.[0-9]+)(.*)/\2|\3/g' \
      | sed -r 's/^ +//g
                s/\| +/|/g
                s/ +/ /g
                s/\$//g
                :a
                s/([0-9])\.([0-9])/\1\2/g
                ta' \
      | sed -r ':a
                N
                s/\n/|/g
                ba' \
      | gawk -F'|' '{if($2!~/^[0-9]/) {print $1,"",""}
                     else {print $1,$2,$3}}' OFS='|' \
      | sed -r ':a
                s/\|/\n/g
                ta' \
      | sed -r '1s/(.*)/"modelo": "\1",/
                2s/(.*)/"precio": "\1",/
                3s/(.*)/"observaciones": "\1"/' \
      | sed -r '1i \\{' \
      | sed -r '$a \\}' \
      | jq '. | {
        marca           : "benelli"        ,
        modelo          : .modelo          ,
        precio_lista    : .precio          ,
        precio_con_bono : null             ,
        valor_bono      : null
        } ' \
      | jq '[.]' --compact-output \
      | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' \
      | sed -r 's/"//g'
    fi
    #   observaciones   : .observaciones
    #### }}}
    #### keeway OK {{{
    if [[ "${1}" == 10 ]] ; then
      cat "${2}" \
      | pup "div.cajaBotonera2 > div , \
             div.cajaFotoInt > div.cajafotoGaleria > div > div > ul , \
             div.cajaFotoInt > div.cajafotoGaleria > div > div > p" \
      | iconv -f UTF-8 -t ISO-8859-1 \
      | pup 'div, ul > li:nth-child(1), ul > li:nth-child(2), ul > li:nth-child(3), p:contains("Precios válidos") json{}' \
      | jq '. |
        {
        marca                   :  "keeway"             ,
        modelo                  : .[0].text             ,
        precio_lista            : .[3].children[0].text ,
        precio_con_bono         : .[1].children[0].text ,
        valor_bono              : .[2].children[0].text
        } ' \
      | jq '[.]' --compact-output \
      | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' \
      | sed -r 's/"//g
                s/\$//g
                s/ c\/IVA//g
                :a
                s/([0-9])\.([0-9])/\1\2/g
                ta'
    fi
    #   observaciones           : .[4].text
    #### }}}
    #### linhai OK {{{
    if [[ "${1}" == 11 ]] ; then
      cat "${2}" \
      | pup "#MRcon > div.justify > div.two.box.clearfix" \
      | grep -i --color 'title=\|precio\|bono' \
      | sed -r 's/.*fancyVideo" //
                s/href.*//
                s/<!-- &lt;h3&gt;//
                s/&lt;\/h3&gt;//
                s/ -->//
                s/&lt;br&gt;//
                s/ +$//g
                s/^ +//g
                s/=/ /g
                s/"//g' \
      | sed -r 's/title //
                s/Precio con bono: //
                s/Bono total: //
                s/Precio lista //
                s/://' \
      | sed -r 's/\$//
                s/ c\/IVA//
                :a
                s/([0-9])\.([0-9])/\1\2/g
                ta' \
      | sed -r '1s/(.*)/"modelo": "\1",/
                2s/(.*)/"precio_con_bono": "\1",/
                3s/(.*)/"bono_total": "\1",/
                4s/(.*)/"precio_lista": "\1",/
                5s/(.*)/"observaciones": "\1"/' \
      | sed -r '1i \\{' \
      | sed -r '$a \\}' \
      | jq '. | {
        marca           : "linhai"         ,
        modelo          : .modelo          ,
        precio_lista    : .precio_lista    ,
        precio_con_bono : .precio_con_bono ,
        valor_bono      : .bono_total
        } ' \
      | jq '[.]' --compact-output \
      | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' \
      | sed -r 's/"//g'
    fi
    #   observaciones   : .observaciones
    #### }}}
    #### motossym OK NORMALIZAR {{{
    if [[ "${1}" == 12 ]] ; then
      cat "${2}" \
        | pup '#product_list > li.ajax_block_product.last_item.alternate_item.clearfix json{}' \
        | jq '.[] | {
          marca           : "motossym"                                ,
          modelo          : .children[1].children[1].children[0].text ,
          precio_lista    : .children[2].children[0].children[0].text ,
          precio_con_bono : null                                      ,
          valor_bono      : null
          }
          ' \
        | jq '[.]' --compact-output \
        | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' \
        | sed -r 's/"//g
                  s/\$ //
                  :a
                  s/([0-9])\.([0-9])/\1\2/g
                  ta'

      # | pup 'div.center_block > h3 > a attr{title}' \
      # | pup 'div.right_block > div > span.price text{}' \
      # | pup 'div.center_block > p > a text{}' \
    fi
    #### }}}

  }

  export -f ExtraccionMotos
