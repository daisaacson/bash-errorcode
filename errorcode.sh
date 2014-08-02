# Print green text
print_green () 
{ 
    printf '\001\033[0;32m\002%s\001\033[0m\002' $1;
}
# Print red text
print_red () 
{ 
    printf '\001\033[1;31m\002%s\001\033[0m\002' $1;
}
# Print error codes
ps1_error () 
{ 
    codes=${@};   # array of return codes
    codes_sum=0;  # sum of all return codes

    # Get sum of all return codes
    for c in $codes;
    do
        codes_sum=$((codes_sum+$c));
    done;

    # If there were errors, print codes
    if [[ ! $codes_sum -eq 0 ]]; then
        num_codes=$#;  # number of return codes
        use_colors=1;  # enable colors

        # Check number of colors supported
        if [[ $(tput colors) -lt 8 ]]; then
            use_colors=0
        fi

        # Print codes if there were errors
        printf ' ';
        for code in $codes;
        do
            # Print error code in applicable color
            if [[ $use_colors -eq 1 ]]; then
                if [[ $code -eq 0 ]]; then
                    print_green $code;
                else
                    print_red $code;
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
