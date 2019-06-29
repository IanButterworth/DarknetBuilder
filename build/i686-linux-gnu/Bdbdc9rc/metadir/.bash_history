trap "save_env" EXIT
trap "save_env; save_srcdir" INT TERM ERR
set -e
tmpify_srcdir
cd $WORKSPACE/srcdir/darknet-*
./configure --prefix=$prefix --host=$target
./configure --prefix=$prefix --host=$target
save_srcdir
./configure --prefix=$prefix --host=$target
