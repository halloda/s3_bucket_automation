import requests 
from requests.auth import HTTPDigestAuth
import json 
import boto3

url='https://api.coindesk.com/v1/bpi/currentprice.json'

r=requests.get(url)
newFile=r.json()



s3=boto3.resource(
service_name='s3',
region_name='us-east-2',
aws_access_key_id='',
aws_secret_access_key=''
)


file_upload=s3.Object('jwbitcbucket','API_data.json')


file_upload.put(

    Body=json.dumps(newFile).encode('UTF-8')
 
)

#-------Create a file: We'll need this later to create a file every 5 minutes 

#def create_file(size, fileName,fileContent):
  #  randomFileName=''.join([str(uuid.uuid4().hex[:6]), fileName])

