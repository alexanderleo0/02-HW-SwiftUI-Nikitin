MODULE="Modules/Networking/Sources/Networking/"

openapi-generator generate -i "catsapi.yml" -g swift5 -o "api-mobile"
rm -r $MODULE""*


cp -R "api-mobile/OpenAPIClient/Classes/OpenAPIs/". $MODULE

rm -r "api-mobile"
