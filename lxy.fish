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
  
  function __parse_page_and_print
    set -l page (curl --silent "https://learnxinyminutes.com/$argv[1]" | htmlq "#doc" | string collect)
    

    set -l md (echo $page |  htmlq "p, pre" | string replace -a "</p>" "\n</p>" | string replace -ra "<pre .*>" "<pre>```$argv[1]" | string replace -a "</pre>" "```</pre>" | htmlq --text | string collect )

    printf "%s\n" $md

  end
  
  #TODO(koalanis): make this better
  __check_dep "bat"
  __check_dep "htmlq"
  
  # create list of supported languages in the tutorials
  set -l _OPTIONS (curl --silent https://learnxinyminutes.com/ | htmlq ".name" | htmlq "a"  --attribute href | cat | string trim -c /)
  
  if contains $argv[1] $_OPTIONS
    __parse_page_and_print $argv[1]
  else
    echo "No record found for $argv[1]"
  end


end
