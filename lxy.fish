# Defined via `source`
function lxy
  set _DATA (curl --silent https://learnxinyminutes.com/ | htmlq ".name" | htmlq "a"  --attribute href | cat | string trim -c /)
  if contains $argv[1] $_DATA
    curl --silent "https://learnxinyminutes.com/$argv[1]" |  htmlq "pre" --text | bat --language $argv[1]
  else
    echo "No record found for $argv[1]"
  end
end
