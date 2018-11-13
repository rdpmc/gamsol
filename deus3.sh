#!/bin/bash

a0=1
b0=2
c0=3
# - начальные условия (a0 - ближняя, b0-левая дальняя, c0-правя дальняя, стоим лицом к секретной двери, которую открывает головоломка)

rand2 ()
{
local r=$(($RANDOM/16384))
return $r
}

rand3 ()
{
local r=$(($RANDOM/10923))
return $r
}

up()
{
echo "up 1" >/dev/stderr
a=$((a+1))
if [ $a -eq 4 ];then
a=1
fi
b=$((b-1))
c=$((c+1))
test $b -eq 0 && b=1
test $c -eq 4 && c=3
return 0
}

run()
{
local n=1 lim="$1" rc
echo "Lim=$lim" >/dev/stderr
while [ true ];do
rand2
r=$?
test $r -eq 0 && { a1=$a; b1=$b; c1=$c; a=$b1; b=$c1; c=$a1; echo "rot 1" > /dev/stderr; }
test $r -eq 1 && { a1=$a; b1=$b; c1=$c; a=$c1; b=$a1; c=$b1; echo "rot 2" > /dev/stderr; }
if [ $a0 -eq $a ] && [ $b0 -eq $b ] && [ $c0 -eq $c ];then
echo "OK! —----------------------------" >/dev/stderr
rc=0
break
fi
echo "rot:a=$a b=$b c=$c" >/dev/stderr
rand3
s=$?
s=$((s+1))
#[1;3]
while [ $s -gt 0 ];do
up
s=$((s-1))
if [ $a0 -eq $a ] && [ $b0 -eq $b ] && [ $c0 -eq $c ];then
echo "OK!" >/dev/stderr
break
fi
echo "up:a=$a b=$b c=$c" >/dev/stderr
done
echo "s=$s" >/dev/stderr
if [ $s -gt 0 ];then
echo "OK! —----------------------------" >/dev/stderr
rc=0
break
fi
n=$((n+1))
echo "" >/dev/stderr
if [ "$lim" = "$n" ];then
rc=1
break
fi
done
echo "$n"
return $rc
}

i=0
RUNS=100 #- Число прогонов для поиска
n=""
while [ $i -lt $RUNS ];do
a=1 ; b=1; c=3
echo "Need: $a0 $b0 $c0 ============"
m="`run $n`"
rc=$?
echo "rc=$rc"
test $rc -eq 0 && { n=$m; echo "New lim=$m"; }
echo "Steps: $n"
echo "Got: $a0 $b0 $c0"
echo ""
i=$((i+1))
done

