from bottle import route, run, template, response, request, hook
from bottle import post, get, put, delete, auth_basic
import bottle
import json
import os 
import subprocess 
import socket
import shutil
import requests

#const
HASH_API_KEY=""
DIR_OMVPB="/root/OpenMVPBox"
STACKS_FILE="stacks.json"
DIR_CURRENT_STACKS="/home/ubuntu/stacks"

#read and get all stacks
fileStack = open(os.path.join(DIR_OMVPB, STACKS_FILE),'r')
allStacksJson=json.load(fileStack)
fileStack.close()

#to get ip
socket.gethostbyname(socket.gethostname())

#get hashpassword A6cS0Gi6rEDJPZzjeM3q
#HASH_API_KEY="$apr1$olft3arc$p05VGVzcFENFUvqbrd5LL0"

_allow_origin = '*'
_allow_methods = 'PUT, GET, POST, DELETE, OPTIONS'
_allow_headers = 'Authorization, Origin, Accept, Content-Type, X-Requested-With'

def enable_cors():
    '''Add headers to enable CORS'''
    response.headers['Access-Control-Allow-Origin'] = _allow_origin
    response.headers['Access-Control-Allow-Methods'] = _allow_methods
    response.headers['Access-Control-Allow-Headers'] = _allow_headers
  
def validateKey():
    apkey=request.headers['api-key']
    if(apkey==HASH_API_KEY):
        return True 
    else:
        return False        

def auth(valid=validateKey):
    print(request)
    def _auth(f):
        def _auth_wrap():
            if not valid():
                raise Exception('redirect')
            return f()
        return _auth_wrap
    return _auth

def readApkiKey(pathfile):
    file = open(pathfile, "r")
    HASH_API_KEY=str(file.readline())
    print (HASH_API_KEY)
    file.close()

def changeVolumePath(pathfile, patternToFind, replacement):
    allLine=""
    file = open(pathfile, "r")
    for line in file:      
        if(line.find(patternToFind)!=-1):
            line=line.replace(patternToFind,replacement)
        allLine=allLine+line
    file.close()

    f = open(pathfile, "w")
    f.write(allLine)
    f.close()

#window.btoa for javascript
#For testing connexion with Api 
@get('/verifyApiKey')
def verifyApiKey():
    apkey=request.headers['api-key']
    toReturn=""
    if(str(apkey)==str(HASH_API_KEY)):
        toReturn={"api-key": "success"} 
    else:
        toReturn={"api-key": "error"} 
    return toReturn
  

#get local ip
@get('/myIp')
@auth()
def myLocalIp():
    toReturn={"localIp": socket.gethostbyname(socket.gethostname())}    
    return toReturn

#get public ip for NDD
@get('/myIpPublic')
@auth()
def myPublicIp():
    url = "https://ifconfig.co"
    headers = {"Accept": "application/json"}
    res = requests.get(url, headers=headers)   
    json_req=json.loads(res.text)  
    toReturn={"publicIP": json_req["ip"]}    
    return toReturn

#get all stack available
@get('/allStack')
def getAllStacks():   
    toReturn = allStacksJson
    return toReturn

#get all installed stack
@get('/installedStack')
@auth()
def getAllSintalledStack():  
    dirList = os.listdir(DIR_CURRENT_STACKS) 
    toReturn=[]    
    for dir in dirList:
        if(os.path.isdir(os.path.join(DIR_CURRENT_STACKS,dir))):
            toReturn.append(dir)
    return json.dumps(toReturn)

#create stack
@post('/create')   
def createStack():   

    allCommandToRunToDeploy=[]
    tmpStack={}  
    idStack=request.json["id"]     

    for aStack in allStacksJson["stacks"]:
        if(aStack['id']==idStack):
            tmpStack=aStack
            break
    #print (tmpStack)

    if (len(tmpStack)==0):
        return "not found"

    #first arg is the script to use for installion
    allCommandToRunToDeploy.append(tmpStack["installScript"])

    #get env from web    
    for aEnv in request.json["env"]:
        allCommandToRunToDeploy.append(aEnv["value"])
    
    #print (allCommandToRunToDeploy)
    newDirNameStack=str(request.json["userid"])+"_"+str(tmpStack["title"])

    #copy template
    shutil.copytree(tmpStack["pathLocalDirStack"], os.path.join(DIR_CURRENT_STACKS,newDirNameStack))    

    #launch deploy
    os.chdir(os.path.join(DIR_CURRENT_STACKS,newDirNameStack))
    #change env var
    changeVolumePath(".env","/root/OpenMVPBox/",DIR_CURRENT_STACKS+"/"+str(request.json["userid"])+"_")
    subprocess.run(allCommandToRunToDeploy, shell=False)
    os.chdir(DIR_CURRENT_STACKS)
   
    return ""

@post('/createRepo')   
def createStackRepo():   
    allCommandToRunToDeploy=[]
    tmpStack={}  
    idStack=request.json["id"]
     

    for aStack in allStacksJson["stacks"]:
        if(aStack['id']==idStack):
            tmpStack=aStack
            break
    #print (tmpStack)

    if (len(tmpStack)==0):
        return "not found"

    #first arg is the script to use for installion
    allCommandToRunToDeploy.append(tmpStack["installScript"])
    allCommandToRunToDeploy.append("clone")

    #get env from web    
    allCommandToRunToDeploy.append(request.json["env"][0]["value"])
    allCommandToRunToDeploy.append(".")
    
    print (allCommandToRunToDeploy)
    newDirNameStack=str(request.json["userid"])+"_"+str(tmpStack["title"])

    #copy template
    os.mkdir(os.path.join(DIR_CURRENT_STACKS,newDirNameStack))

    #launch deploy
    os.chdir(os.path.join(DIR_CURRENT_STACKS,newDirNameStack))
    #change env var
    subprocess.run(allCommandToRunToDeploy, shell=False)
    subprocess.run(["docker-compose","up"], shell=False)    
    os.chdir(DIR_CURRENT_STACKS)

    return ""

#delete stack
@auth()
@delete('/delete/<dir_name>') 
def deleteStack(dir_name):
    #stoppe docker
    os.chdir(os.path.join(DIR_CURRENT_STACKS,dir_name))
    subprocess.run(["docker-compose","-f","docker-compose-with-traefik.yml", "down"], shell=False)
    os.chdir(DIR_CURRENT_STACKS)

    #remove all volmue
    os.system("docker volume ls | grep '"+str(dir_name)+"' | awk '{print $2}' | xargs docker volume rm")
    
    #delete the dir
    shutil.rmtree(os.path.join(DIR_CURRENT_STACKS,dir_name))
    
    return ""

#settings conf
app = application = bottle.default_app()
app.add_hook('after_request', enable_cors)

if __name__ == '__main__':
    #set apiKey
    readApkiKey("/root/OpenMVPBox/apiKey")

    #run service
    bottle.run(host=socket.gethostbyname(socket.gethostname()), port=9080)

