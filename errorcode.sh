# Variables you can put in your .bash_profile etc.
#     PS1_ERROR_0  color for exit code 0  0;32m is green
#     PS1_ERROR_1  color for error codes  1;31m is bold red

# Print text in color
ps1_print_color ()
{
    m="${1:-xxx}";  # message
    c="${2:-0m}";   # color
    printf '\001\033[%s\002%s\001\033[0m\002' "$c" "$m"
}
# Print error codes
ps1_error () 
{ 
    codes=${@};                       # array of return codes
    error=0;                          # boolean if error exists
    color_0="${PS1_ERROR_0:-0;32m}";  # good color
    color_1="${PS1_ERROR_1:-1;31m}";  # bad color

    # Determine if there were any errors
    for code in $codes;
    do
        if [[ $code -ne 0 ]]; then
            error=1;
            break;
        fi;
    done;

    # If there were errors, print codes
    if [[ $error -ne 0 ]]; then
        num_codes=$#;  # number of return codes
        use_colors=1;  # enable colors

        # Check number of colors supported
        if [[ $(tput colors) -lt 8 ]]; then
            use_colors=0;
        fi;

        # Print codes if there were errors
        printf ' ';
        for code in $codes;
        do
            # Print error code in applicable color
            if [[ $use_colors -eq 1 ]]; then
                if [[ $code -eq 0 ]]; then
                    ps1_print_color $code $color_0;
                else
                    ps1_print_color $code $color_1;
                fi;
            else
                printf '%s' $code;
            fi;
            # Print speerater if more codes in array
            if [[ $num_codes -gt 1 ]]; then
                printf '|';  # print seperater
                num_codes=$((num_codes-1));
            fi;
        done;
        printf ' ';
    fi
}

# Set PS1 variable
PS1='[\u@\h \W]$(ps1_error ${PIPESTATUS[*]})\$ '
