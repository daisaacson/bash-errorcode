function ps1_error {
  if [[ ! $1 -eq 0 ]]; then
    printf ' \001\033[1;31m\002%s\001\033[0m\002 ' $1
  fi  
}
PS1='[\u@\h \W]$(ps1_error $?)\$ '
