
  function DefinirYamaha () {

    cat "${1}" \
      | jq '
        if(.['"${3}"'].children[0].tag == "span") then
        (
        {
         marca           : "yamaha"                     ,
         modelo          : .['"${2}"'].text             ,
         precio_lista    : .['"${3}"'].children[0].text ,
         precio_con_bono : null                         ,
         valor_bono      : null
       }
       )
     else
       (
       {
         marca           : "yamaha"                                 ,
         modelo          : .['"${2}"'].text                         ,
         precio_lista    : .['"${3}"'].children[0].children[0].text ,
         precio_con_bono : .['"${3}"'].children[1].children[0].text ,
         valor_bono      : null
       }
       )
     end
        ' \
      | jq '[.]' --compact-output \
      | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' \
      | sed -r 's/"//g
                s/â€“/-/
                s/Ã‰/É/
                s/Ã“/Ó/
                s/Ã¢â‚¬â€œ/-/
                s/Ãƒâ€°/É/
                s/Ãƒâ€œ/Ó/
                s/N\./N/
                :a
                s/([0-9])\.([0-9])/\1\2/g
                ta'

    }

    export -f DefinirYamaha
