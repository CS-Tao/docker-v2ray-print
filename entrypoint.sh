#!/bin/sh
set -e

OUTPUT_FOLDER=volume

if [ -f $OUTPUT_FOLDER/config.json ]; then
  cp $OUTPUT_FOLDER/config.json ./config.json
fi

OUTPUT_FILE=$OUTPUT_FOLDER/output.txt

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

cat ${OUTPUT_FILE}

echo -e "\033[32mWelcome to the new world. And in this world, you can fly anywhere you want. See you next time.\033[0m\n"
