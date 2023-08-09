
  source "DefinirRutaProyecto.sh"

  declare -x ImpOut="LlamarArchivosImportar.R"
  declare -x DefinirImportacion=$( \
      find $csvdir -type f \
      | sort \
      | sed -r 's/(.*)\/(.*)\.(.*)/\2 <- ImportarDataframe\( \"\2\" , \"\1\/\2\.\3\" \) ; PreciosMotos <- data.frame\(rbind\(\2\)\)/' \
      | sed -r '1i \\load\(\".RData\"\)
                1i \\
                1i \\source\(\"FuncionImportar.R\"\)
                1i \\' \
      | sed -r '$a \\
                $a \\PreciosMotos <- PreciosMotos[!duplicated(PreciosMotos),]' \
      | sed -r '$a \\
                $a \\save.image()' \
      )

  echo "${DefinirImportacion}" > "${ImpOut}"
