function oi
    if test "$argv[1]" = "dziś"
        set date (date +%Y-%m-%d)
    else
        set date $argv[1]
    end
    pkg query "%t %n" | sort -n | awk '{cmd="date -r "$1" +\"%Y-%m-%d %H:%M\""; cmd | getline d; close(cmd); print d, $2}' | grep $date
end
