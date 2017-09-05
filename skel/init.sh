
eip=$(dig +short myip.opendns.com @resolver1.opendns.com)

help()  { 
  echo "
  Usage: ewf-run.sh OPTIONS
  OPTIONS:
    -r | --release - Parity client version. Default: v1.7.1
  "
}


# Read command line
while [ "$1" != "" ]; do
    case $1 in
	-r | --release)		    shift
                                PARITY_RELEASE=$1
                                ;;
        -h | --help )           help
                                return 
                                ;;
        * )                    	help
                                return
    esac
    shift
done
