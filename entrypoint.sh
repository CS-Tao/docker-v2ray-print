#!/bin/sh
set -e

FOLDER=volume

if [ -f $FOLDER/config.json ]; then
  cp $FOLDER/config.json ./config.json
else
  echo -e "\033[31mError: No config.json found in ${FOLDER}. Maybe volume of config.json was not set. \033[0m" && exit 1
fi

OUTPUT_FILE=$FOLDER/output.txt

echo "---------------------------- Config ---------------------------"
echo "import json
print(json.dumps($(cat ./config.json), sort_keys=True, indent=2))" \
  | python3
echo "---------------------------- Config ---------------------------"

echo "Generate vmess link..."
python3 ./json2vmess.py $@ ./config.json > ${OUTPUT_FILE}

echo "Generate QR code..."
node index.js $(cat ${OUTPUT_FILE}) > ${OUTPUT_FILE}
echo -e "\033[36mLast launch time: $(date) \033[0m\n" >> ${OUTPUT_FILE}

rm ./config.json

cat ${OUTPUT_FILE}

[ -n SAY_GOODBYE ] && echo -e ${SAY_GOODBYE}
