http -v POST 10.233.64.43:8081/subjects/data-value-events-key/versions \
  Accept:application/vnd.schemaregistry.v1+json \
  schema="{\"type\": \"string\"}"

http -v POST 10.233.64.43:8081/subjects/data-value-events-value/versions \
  Accept:application/vnd.schemaregistry.v1+json \
  schema=@avro/data-value-event.avsc



http -v POST 10.233.64.43:8081/subjects/aggregate-data-value-events-key/versions \
  Accept:application/vnd.schemaregistry.v1+json \
  schema="{\"type\": \"string\"}"

http -v POST 10.233.64.43:8081/subjects/aggregate-data-value-events-value/versions \
  Accept:application/vnd.schemaregistry.v1+json \
  schema=@avro/aggregate-data-value-event.avsc
