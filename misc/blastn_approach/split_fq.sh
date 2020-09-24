read -p 'File name: ' input
read -p 'Number of parts to split file into: ' parts
line_no=$(< "$input" wc -l)
echo $line_no 'lines in file'
read_no=$(expr $line_no / 4)
echo $read_no 'reads total'
increment=$(expr $read_no / $parts)
echo $increment 'reads will be processed at a time'

first=1

for i in $(seq 1 $(expr $parts - 1)); do
  echo 'processing part' $i
  last=$(expr $i \* $increment \* 4)
  stop=$(expr $last + 1)
  sed -n "$first,${last}p;${stop}q" $input > ${i}_${input}
  first=$stop
done

echo 'processing part' $parts
sed -n "$first,${line_no}p" $input > ${parts}_${input}
