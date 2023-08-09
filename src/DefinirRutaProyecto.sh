
  function DefinirRutaExtraccion () {

    curstr=$(locate .findme)
    mandir=$(echo $curstr | sed -r 's/(.*)\/(.*)/\1/')
    curfle=$(echo $curstr | sed -r 's/(.*)\/(.*)/\1\/\.curdir/')
    echo $mandir > $curfle
    srcdir="$mandir/src"
    htmdir="$mandir/motos/html"
    jsndir="$mandir/motos/json"
    csvdir="$mandir/motos/csv"

  }

  export -f DefinirRutaExtraccion

  DefinirRutaExtraccion
  declare -x srcdir="$mandir/src"
  declare -x htmdir="$mandir/motos/html"
  declare -x jsndir="$mandir/motos/json"
  declare -x csvdir="$mandir/motos/csv"
