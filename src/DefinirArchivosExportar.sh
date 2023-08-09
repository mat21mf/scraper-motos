
  source "DefinirRutaProyecto.sh"

  declare -x ExpOut="LlamarArchivosExportar.R"
  declare -x DefinirExportacion=$( \
      find $csvdir -type f \
      | sort \
      | sed -r 's/(.*)\/(.*)\.(.*)/ExportarDataframe\( \2 , \"\.\.\/xlsx\/\2\.xlsx\" , \"PreciosMotos\" \) ; rm\(\2\)/' \
      | sed -r '$s/(.*)\( (.*) , (.*) , (.*) \) ; (.*)/\1\( PreciosMotos                    , \3 , \4 \) ; \5/' \
      | sed -r '1i \\load\(\".RData\"\)
                1i \\
                1i \\source\(\"FuncionExportar.R\"\)
                1i \\' \
      | sed -r '$a \\
                $a \\save.image()' \
      )

  echo "${DefinirExportacion}" > "${ExpOut}"
