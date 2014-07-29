# Print green text
function print_green {
  printf '\001\033[0;32m\002%s\001\033[0m\002' $1
}
# Print red text
function print_red {
  printf '\001\033[1;31m\002%s\001\033[0m\002' $1
}
# Print error codes
function ps1_error {
  # Sum of values in $PIPESTATUS
  sum=0; for i in ${@}; do sum=$(($sum + $i)); done

  # If error, print codes
  if [[ ! $sum -eq 0 ]]; then
    num_codes=$#
    printf ' '
    # For each error code
    for c in ${@}; do
      if [[ $c -eq 0 ]]; then
        print_green $c
      else
        print_red $c
      fi
      # If more codes, print a |
      if [[ $num_codes -gt 1 ]]; then
        printf '%s' "|"
        num_codes=$(($num_codes-1))
      fi
    done
    printf ' '
  fi
}

# Set PS1 variable
PS1='[\u@\h \W]$(ps1_error ${PIPESTATUS[*]})\$ '
