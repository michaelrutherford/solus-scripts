#!/bin/bash
# Using ii bot responds to !commands

# Channel must be lower case
channel="#solus-chat"
network="irc.freenode.net"
networkinfile="/home/justin/irc/${network}/in"
infile="/home/justin/irc/${network}/${channel}/in"
outfile="/home/justin/irc/${network}/${channel}/out"
quotesfile="/home/justin/quotes.txt"

echo "/join ${channel}" > $networkinfile

function quote {
    if [[ $(wc -l ${quotesfile} | cut -d" " -f 1) -gt 0 ]]
        then
            totalquotes=$(wc -l ${quotesfile} | cut -d " " -f 1)
            if [[ $@ -gt ${totalquotes} ]]
                then
                    echo "Invalid quote ID" > $infile
                else
                    quote=$(head -n${@} ${quotesfile} | tail -n1 )
                    echo "[Quote ${@}]: ${quote}" > $infile
            fi
        else
            echo "Quotes Database empty, you can add one using !addquote <quote>" > $infile
    fi
}

function addquote {
    echo "${@}" >> $quotesfile
    quoteid=$(wc -l $quotesfile | cut -d" " -f 1)
    echo "Quote ID ${quoteid} added to the database." > $infile
}

function randomquote {
    if [[ $(wc -l ${quotesfile} | cut -d" " -f 1) -gt 0 ]]
        then
            totalquotes=$(wc -l $quotesfile | cut -d" " -f 1)
            quoteid=$(shuf -i 1-${totalquotes} -n 1)
            quote=$(head -n${quoteid} ${quotesfile} | tail -n1)
            echo "[Quote ${quoteid}]: ${quote}" > $infile
        else
            echo "Quotes Database empty, you can add one using !addquote <quote>" > $infile
    fi
}

function quotes {
    # Check if quote db has anything in it
    if [[ $(wc -l ${quotesfile} | cut -d" " -f 1) -gt 0 ]]
        then
            echo "There are $(wc -l ${quotesfile} | cut -d " " -f 1) quotes in the system." > $infile
        else
            echo "Quotes Database empty, you can add one using !addquote <quote>" > $infile
    fi
}

# This listens to the output file of ii and responds accordingly
while inotifywait -qqe modify $outfile; do 
    # This ensures Bacon Bot and I don't have a war.   
    if [[ $username = "Bacon_Bot" ]]; then echo "Bacon_Bot, ignoring.";fi
    # This arg gets the command the user gave
    arg=$(tail -n 1 $outfile | cut -c18- | sed 's|[<>,]||g' | cut -d' ' -f2)
    # arg2 is for adding quotes
    arg2=$(tail -n 1 $outfile | cut -c18- | sed 's|[<>,]||g' | cut -d' ' -f3-999)
    # Arg3 is for retrieving quotes
    arg3=$(tail -n 1 $outfile | cut -c18- | sed 's|[<>,]||g' | cut -d' ' -f3)
    shift
    case "${arg}" in
#Fun
        !bacon)
            echo $foruser" It's raining bacon!! ~~~~~~~~~~~~~~" > $infile
            ;;
        !addquote)
            addquote ${arg2}
            ;;
        !quote)
            quote ${arg3}
            ;;
        !randomquote)
            randomquote
            ;;
        !quotes)
            quotes
            ;;
#Wiki
        !wiki)
            echo $foruser" https://wiki.solus-project.com/" > $infile
            ;;
        !go)
            echo $foruser" https://wiki.solus-project.com/Golang" > $infile
            ;;
        !rust)
            echo $foruser" https://wiki.solus-project.com/Rust" > $infile
            ;;
        !efi)
            echo $foruser" https://wiki.solus-project.com/UEFI" > $infile
            ;;
        !installation)
            echo $foruser" https://wiki.solus-project.com/Installation" > $infile
            ;;
        !evobuild)
            echo $foruser" https://wiki.solus-project.com/EvoBuild" > $infile
            ;;
        !packaging)
            echo $foruser" https://wiki.solus-project.com/Packaging" > $infile
            ;;
        !eopkg)
            echo $foruser" https://wiki.solus-project.com/Package_Management" > $infile
            ;;
        !applications)
            echo $foruser" https://wiki.solus-project.com/Applications" > $infile
            ;;
        !chrome)
            echo $foruser" https://wiki.solus-project.com/Chrome" > $infile
            ;;
        !opera)
            echo $foruser" https://wiki.solus-project.com/3rdParty" > $infile
            ;;
        !vivaldi)
            echo $foruser" https://wiki.solus-project.com/3rdParty" > $infile
            ;;
        !virtualbox)
            echo $foruser" https://wiki.solus-project.com/VirtualBox" > $infile
            ;;
        !rules)
            echo $foruser" https://wiki.solus-project.com/Community_Guidelines" > $infile
            ;;
#Solus        
        !bugs)
            echo $foruser" https://bugs.solus-project.com/" > $infile
            ;;
        !builds)
            echo $foruser" https://build.solus-project.com" > $infile
            ;;
        !forums)
            echo $foruser" https://solus-project.com/forums/" > $infile
            ;;
        !git)
            echo $foruser" https://git.solus-project.com/" > $infile
            ;;
        !help)
            echo $foruser" " > $infile
            ;;
        !reddit)
            echo $foruser" https://www.reddit.com/r/SolusProject/" > $infile
            ;;
        !search)
            ~/eopkgsearch.sh $foruser
            cat /tmp/search2 > $infile
            ;;
        !website)
            echo $foruser" https://solus-project.com/" > $infile
            ;;
        *)
            echo "Unrecognised command"
            ;;
    esac
done
