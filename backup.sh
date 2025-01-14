#!/bin/bash
set -ex
JSON="[]"

# Get all links from the page then filter only the zip files
 while read line; do
    # Iterate over each zip if there is any
    if [ -n "$line" ]; then
        FOLDER=$(echo $line | sha1sum | awk '{print$1}')

        mkdir -p /data/temp/$FOLDER
        cd /data/temp/$FOLDER

        aria2c -c --auto-file-renaming=false --allow-overwrite=false --save-session="session.aria2" --force-save=true $line

        FILE=$(ls *.zip | tail -n1)
        SIZE=$(stat -c %s "./$FILE")

        # Check zip integrity
        unzip -t "./$FILE"
        # Generate sha256 checksum
        sha256sum "./$FILE" > "./$FILE.sha256"
        # Upload to S3
        aws s3 cp "./$FILE" "s3://$S3_BUCKET/${S3_PREFIX}${FILE}"
        aws s3 cp "./$FILE.sha256" "s3://$S3_BUCKET/${S3_PREFIX}${FILE}.sha256"

        JSON=$(echo "$JSON" | jq \
            --arg name "$FILE" \
            --arg url "${PUBLIC_URL}${FILE}" \
            --argjson size "$SIZE" \
            '. += [ { name: $name, url: $url, size: $size } ]')

    fi
done < <(curl https://class.devsamurai.com.br | grep -E -io 'href="[^\"]+"' | awk -F\" '{print$2}' | grep ".zip" | tail -n2)

# Generate index file
export JSON=$JSON
envsubst < /data/index.html > /data/temp/index.html
aws s3 cp /data/temp/index.html "s3://$S3_BUCKET/${S3_PREFIX}index.html"