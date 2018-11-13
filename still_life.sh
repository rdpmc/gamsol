
#!/bin/bash
#
a0=0
b0=2
c0=0
d0=3
e0=1
#
a1=0
b1=0
c1=2
d1=0
e1=0

vmas="a b c d e"
v=0
Right ()
{
local v
v=`expr 1 + $2 + $1`
if [ $v -gt 3 ];then
v=`expr $v - 4`
fi
echo -n "$v"
return 0
}

Left ()
{
local v
v=`expr $1 - 1 - $2`
if [ $v -lt 0 ];then
v=`expr $v + 4`
fi
echo -n "$v"
return 0
}
i=0
it=100
out=""
a=$a0;b=$b0;c=$c0;d=$d0;e=$e0
n=1
echo ""
echo -n "Try $n :"
while [ true ];do
nr=`expr $RANDOM % 3`
nv=`expr $RANDOM % 5`
case $nv in
0 )
a=`Right $a $nr`
b=`Left $b $nr`
c=`Right $c $nr`
out="$out A,$nr "
;;
1 )
b=`Right $b $nr`
e=`Left $e $nr`
a=`Right $a $nr`
out="$out B,$nr "
;;
2 )
c=`Right $c $nr`
b=`Left $b $nr`
d=`Left $d $nr`
out="$out C,$nr "
;;
3 )
d=`Right $d $nr`
a=`Left $a $nr`
e=`Right $e $nr`
out="$out D,$nr "
;;
4 )
e=`Right $e $nr`
c=`Left $c $nr`
d=`Right $d $nr`
out="$out E,$nr "
;;
esac
i=`expr $i + 1`
if [ "$a$b$c$d$e" = "$a1$b1$c1$d1$e1" ];then
if [ $i -lt $it ];then
echo "OUT: $out"
echo "ITERS: $i"
it=$i
fi
fi
if [ $i -eq $it ];then
a=$a0;b=$b0;c=$c0;d=$d0;e=$e0
i=0
n=`expr $n + 1`
echo ""
echo -n "Try $n :"
out=""
fi
echo -n "."
done
