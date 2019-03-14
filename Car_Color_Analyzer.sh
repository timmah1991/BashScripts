#/bin/bash

declare -a cars=( brown yellow green red blue green green tan beige red)
IFS=$'\n' GLOBIGNORE='*' sorted_cars=($(printf '%s\n' ${cars[@]} | awk '{ print length($0) " " $0; }' | sort -n | cut -d ' ' -f 2-))


arrcount="${#sorted_cars[@]}"
echo $arrcount "is the array object count"
car_vals=()

for (( c=0; c<$arrcount; c++ ))
    do
        car_vals+=(${#sorted_cars[$c]})
    done

echo ${car_vals[@]} "are the word lengths"

uniq=($(printf "%s\n" "${car_vals[@]}" | sort -u | tr '\n' ' '))
echo $uniq "are the unique word lengths"

echo "--"
echo "--"

IFS=$'\x20'
for i in ${uniq[@]}
    do
        echo "car color values with" $i "characters:"
        echo ${sorted_cars[@]} | grep -o -w "\w\{$i,$i\}"
    done
    
echo "--"
echo "--"

echo "Car colors sorted by # of appearances:"
echo ${sorted_cars[@]}  | tr " " "\n" | sort | uniq -c | sort -k2nr | awk '{printf("%s\t%s\n",$2,$1)}END{print}' | head -n -1
