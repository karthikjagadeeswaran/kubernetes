# Import KafkaConsumer from Kafka library
from kafka import KafkaConsumer

# Import sys module
import sys

# Define server with port
bootstrap_servers = ['10.47.0.9:9092']

# Define topic name from where the message will recieve
topicName = 'test'

print("topic",topicName)
# Initialize consumer variable
consumer = KafkaConsumer (topicName, group_id ='group1',bootstrap_servers =
   bootstrap_servers)

print("consumer", consumer.topic)
# Read and print message from consumer
for msg in consumer:
	print("Topic Name=%s,Message=%s"%(msg.topic,msg.value))

# Terminate the script
sys.exit()
