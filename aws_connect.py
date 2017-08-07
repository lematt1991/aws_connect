import boto3
import pdb
from tabulate import tabulate

ec2 = boto3.resource('ec2')

def listInstances():
    instances = []
    for instance in ec2.instances.all():
        dns = instance.public_dns_name if instance.public_dns_name != '' else instance.state['Name']
        instances.append([instance.tags[0]['Value'], instance.id, dns])
    print(tabulate(instances, headers=['Name', 'ID', 'Public DNS/State']))

def getInstance(instanceName):
    for instance in ec2.instances.all():
        if instance.tags[0]['Value'] == instanceName:
            return instance
    return None

def getConnectURL(instanceName):
    instance = getInstance(instanceName)
    print(instance.public_dns_name)

def startEC2(instanceName):
    instance = getInstance(instanceName)
    instance.start()
    instance.wait_until_running()
    print('%s started' % instance.tags[0]['Value'])