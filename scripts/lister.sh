#!/bin/bash
cd
pkg=$1

apt update
apt install apt-rdepends debfoster -y -q

pkgdeps=`apt-rdepends $pkg `debfoster -d ceph | tail -n +2` 2>/dev/null | grep -v -i depends | awk '{print $1}'`
pkgRdeps=`apt-rdepends $pkg `debfoster -d ceph | tail -n +2` 2>/dev/null | grep -i depends | awk '{print $2}' | sort -u`

pkgfiles=`dpkg -L $pkg `debfoster -d ceph | tail -n +2` 2>/dev/null | grep -v -e "\/usr\/share" | grep -v -e "^\/[^\/]*$"`

depsfiles=''
for i in $pkgdeps;
do
  depsfiles+="\n"`dpkg -L $i 2>/dev/null | grep -v -e "\/usr\/share" | grep -v -e "^\/[^\/]*$"`
done

Rdepsfiles=''
for i in $pkgRdeps;
do
  Rdepsfiles+="\n"`dpkg -L $i 2>/dev/null | grep -v -e "\/usr\/share" | grep -v -e "^\/[^\/]*$"`
done

all=`echo "$pkgfiles$depsfiles$Rdepsfiles" | sort -u`
printf "$all" > /host/list.txt
sed '/^$/d' /host/list.txt > trimmed.txt
mv trimmed.txt /host/list.txt

include=( "/usr/bin/ceph*" \
          "/usr/bin/rbd*" \
          "/usr/bin/rados*" \
          "/usr/bin/uu*" \
          "/usr/sbin/uuidd" \
          "/usr/local/bin/*" \
          "/bin/bash" \
          "/bin/cat" \
          "/bin/grep" \
          "/bin/ls" \
          "/sbin/my_init" \
          "/usr/bin/uuidgen" \
          "/usr/bin/awk" \
          "/usr/bin/crushtool" \
          "/bin/mount" \
          "/sbin/mkfs" \
          "/sbin/iptables" \
          "/usr/bin/print" \
          "/usr/bin/runsv*" \
          "/sbin/run*" \
          "/usr/lib/librbd*" \
          "/usr/lib/python2.7/dist-packages/rbd*" \
          )

for n in ${!include[*]}
do
find ${include[n]} | xargs -I {} ldd {} 2>/dev/null | awk '{print $3}' | grep '/' | sort -u | xargs -I {} echo {} >> /tmp/touch
done
cat /tmp/touch | sort -u >> /host/manuallist.txt
rm /tmp/touch

while read in;
do
ldd $in 2>/dev/null | awk '{print $3}' | grep '/' | sort -u | xargs -I {} echo {} >> /tmp/touch
done < /host/list.txt
cat /tmp/touch | sort -u >> /host/lddlist.txt
rm /tmp/touch
