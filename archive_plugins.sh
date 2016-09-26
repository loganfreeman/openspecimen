function move {

  if [ $# -ne 3 ]; then
      echo $0: usage: move old_ver new_ver dest
      exit 1
  fi

  ver=$1
  new=$2
  dest=$3
  pattern="*$ver.jar"
  echo "find . -type f -name $pattern"
  for file in `find . -type f -name "$pattern"`
  do
   fbname=$(basename "$file" .jar)
   nname=`echo $file | sed "s/$ver/$new/"`
   echo $fbname
   if [ -f $nname ]; then
     echo $nname
     echo "remove old version $file"
     mv $file $dest
   fi
  done
}

old=$1
new=$2
move $old $new
