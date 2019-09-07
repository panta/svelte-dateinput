# determine the directory where this script resides
#   (see http://stackoverflow.com/a/246128/1363486)
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
THIS_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
TOP_DIR="${THIS_DIR}"

: ${top_dir:=$TOP_DIR}

if [ "$0" = "$BASH_SOURCE" ] ; then
  echo "ERROR: please source this script."
  exit 1
fi

NODE_VER="v10.16.0"
nvm use ${NODE_VER}
export PATH=${frontend_dir}/node_modules/.bin:$PATH

export top_dir
