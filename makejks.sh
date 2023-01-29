#!/usr/bin/env bash

function usage {
        echo "makejks.sh makes a jks keystore file."
        echo "requirements:"
        echo " keytool (part of java), openssl"
        echo "proper usage:"
        echo " makejks.sh -p password -c public_cert.crt -k private_key.key -a certificate_authority.crt -j output_file.jks"
        echo ""
}

# list of arguments expected in the input
opts=":hp:c:k:a:j:"

while getopts ${opts} arg; do
  case ${arg} in
    h)
        # help/usage
        usage
        exit 0
      ;;
    p)
        # password
        pass=$OPTARG
        ;;
    c)
        # public certificate
        if [ -e $OPTARG ];then
            pubCert=$OPTARG
        else
            echo "$0: File does not exist: $OPTARG" >&2
            exit 1
        fi
        ;;
    k)
        # private key
        if [ -e $OPTARG ];then
            privKey=$OPTARG
        else
            echo "$0: File does not exist: $OPTARG" >&2
            exit 1
        fi
        ;;
    a)
        # cert authority certificate
        if [ -e $OPTARG ];then
            caCert=$OPTARG
        else
            echo "$0: File does not exist: $OPTARG" >&2
            exit 1
        fi
        ;;
    
    j)
        # output jks file
        if [ -e $OPTARG ];then
            echo "$0: File exists: $OPTARG, refusing to overwrite" >&2
            exit 1
        else
            jksFile=$OPTARG
        fi
        ;;
    :)
      echo "$0: Must supply an argument to -$OPTARG." >&2
      exit 1
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      exit 2
      ;;
  esac
done

privKeyDec="${privKey}_nocrypt.key"
chainCert="chaincert.crt"

#echo "value dump: pass $pass, pub $pubCert, priv $privKey, cacert $caCert, privdec $privKeyDec, chain $chainCert"

[ $(which keytool) ] || echo -e "You do not have keytool installed. Bailing out.\ehttps://docs.oracle.com/en/java/javase/12/tools/keytool.html"
[ $(which openssl) ] || echo -e "You do not have openssl installed. Bailing out."

openssl pkcs8 -topk8 -in "${privKey}" -out "${privKeyDec}" -nocrypt -passin pass:"${pass}"
cat "${pubCert}" "${caCert}" > "${chainCert}"
openssl pkcs12 -export -in "${chainCert}" -inkey "${privKeyDec}" -out temp.p12 -passin pass:"${pass}" -passout pass:"${pass}"
keytool -importkeystore -deststorepass "${pass}" -destkeypass "${pass}" -destkeystore "${jksFile}" -srckeystore temp.p12 -srcstoretype PKCS12 -srcstorepass "${pass}"
openssl base64 -in "${jksFile}" -out "${jksFile}.out"
[ -f ${jksFile} ] && rm -f temp.p12
echo "made ${jksFile} keystore and base64 encoded ${jksFile}.out"
[ $(which md5) ] && md5 "${jksFile}"
[ $(which md5sum) ] && md5sum "${jksFile}"

