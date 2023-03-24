MODULE="Modules/Networking/Sources/Networking/"

openapi-generator generate -i "cheapShark.yml" -g swift5 --additional-properties=responseAs=AsyncAwait -o "api-mobile"
rm -r $MODULE""*


cp -R "api-mobile/OpenAPIClient/Classes/OpenAPIs/". $MODULE

rm -r "api-mobile"
