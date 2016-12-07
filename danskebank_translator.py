from rulebase import RuleBase
from rmqConsume import Consumer
from rmqPublish import publish_to_q, publish_to_bank
from queue_names import *
from json import loads, dumps
import requests
import translators as tr
import pika

def on_exchange(ch, method, properties, body):
    print "hello!!!" + body


def callback(ch, method, properties, body):
    m = loads(body)
    result = tr.dumps(m, "danskebank")
    print "danske bank translator: ", result
    publish_to_bank("datdb.cphbusiness.dk",
                 'cphbusiness.bankJSON',
                 result,
    pika.BasicProperties(
        correlation_id="12399942",
        reply_to="danskebank",
    ))
    


consumer = Consumer("localhost", DANSKEBANK_TRANSLATOR_QUEUE)
consumer.on_receive = callback
consumer.consume()