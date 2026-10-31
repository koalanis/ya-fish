# Defined in /home/kaleb/.config/fish/functions/lxy.fish @ line 2
function lxy
  
  if test (count $argv) = 0
    echo "No input given"
    return 1
  end


  function __check_dep
    if not type -q $argv[1]
      echo "Missing dep: $argv[1]"
      return 1
    end
  end
  
  #TODO(koalanis): make this better
  __check_dep "bat"
  __check_dep "htmlq"

  set _DATA (curl --silent https://learnxinyminutes.com/ | htmlq ".name" | htmlq "a"  --attribute href | cat | string trim -c /)
  if contains $argv[1] $_DATA
    curl --silent "https://learnxinyminutes.com/$argv[1]" |  htmlq "pre" --text | bat --language $argv[1]
  else
    echo "No record found for $argv[1]"
  end
end
