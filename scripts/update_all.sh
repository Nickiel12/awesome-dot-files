cur_dir=`dirname $(realpath $0)`
home_dir=$1

echo "WARNING: This WILL override ALL existing settings. Are you sure? (y/n)"
read response

if ($respone -eq "y") then
    /bin/cp -RT $cur_dir/../src/home/.config/ $home_dir/.config/
    /bin/cp -RT $cur_dir/../src/etc /etc
else 
    echo "Aborting"
fi
