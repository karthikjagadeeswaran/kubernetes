confluent local load postgres-sink-live-data-value-events -- -d  kafka-config/postgres-sink-live-data-value-events.properties

confluent local load postgres-sink-data-value-events -- -d  kafka-config/postgres-sink-data-value-events.properties
confluent local load postgres-sink-aggregate-data-value-events -- -d  kafka-config/postgres-sink-aggregate-data-value-events.properties
