from bottle import route, run, template, response, request, hook
from bottle import post, get, put, delete, auth_basic
import bottle
import json
import os 
import subprocess 
from subprocess import check_output
import socket
import shutil
import requests
from bottle import static_file  
import psutil

class EnableCors(object):
    name = 'enable_cors'
    api = 2

    def apply(self, fn, context):
        def _enable_cors(*args, **kwargs):
            # set CORS headers
            response.headers["Accept"]='application/json'
            response.headers['Access-Control-Allow-Origin'] = '*'
            response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, OPTIONS, DELETE'
            response.headers['Access-Control-Allow-Headers'] = 'Origin, Accept, Content-Type, X-Requested-With, X-CSRF-Token, api-key'

            if bottle.request.method != 'OPTIONS':
                # actual request; reply with the actual response
                return fn(*args, **kwargs)

        return _enable_cors


#const
HASH_API_KEY=""
DIR_OMVPB="/root/OpenMVPBox"
STACKS_FILE="stacks.json"
DIR_CURRENT_STACKS="/home/ubuntu/stacks"
url_1='934454596330487839'
url_2='a0uU2eUwhIbkHXgykRl3eJIkkA7vnVerGiNYNlHbjk7VcClYizrrvqQGopb0Dkn1N2LS'

#read and get all stacks
fileStack = open(os.path.join(DIR_OMVPB, STACKS_FILE),'r')
allStacksJson=json.load(fileStack)
fileStack.close()

#to get ip
socket.gethostbyname(socket.gethostname())

#get hashpassword A6cS0Gi6rEDJPZzjeM3q
#HASH_API_KEY="$apr1$olft3arc$p05VGVzcFENFUvqbrd5LL0"
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
    global HASH_API_KEY
    file = open(pathfile, "r")
    HASH_API_KEY=file.readline().strip()
    #HASH_API_KEY="1234"
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

app = application = bottle.default_app()
app.install(EnableCors())
                        
#window.btoa for javascript
#For testing connexion with Api 
@app.route('/verifyApiKey', method=['OPTIONS', 'GET'])
def verifyApiKey():
    apkey=request.headers['api-key']
    toReturn=""
    if(str(apkey)==str(HASH_API_KEY)):
        toReturn={"api-key": "success"} 
    else:
        toReturn={"api-key": "error"} 
    return toReturn
  

#get local ip
@app.route('/myIp', method=['OPTIONS', 'GET'])
@auth()
def myLocalIp():
    toReturn={"localIp": socket.gethostbyname(socket.gethostname())}    
    return toReturn

#get public ip for NDD
@app.route('/myIpPublic', method=['OPTIONS', 'GET'])
@auth()
def myPublicIp():
    url = "https://ifconfig.co"
    headers = {"Accept": "application/json"}
    res = requests.get(url, headers=headers)   
    json_req=json.loads(res.text)  
    toReturn={"publicIP": json_req["ip"]}    
    return toReturn

#get all stack available
@app.route('/allStack', method=['OPTIONS', 'GET'])
@auth()
def getAllStacks():   
    toReturn = allStacksJson
    return toReturn

#get all installed stack
@app.route('/installedStack', method=['OPTIONS', 'GET'])                                             
@auth()
def getAllSintalledStack():  
    dirList = os.listdir(DIR_CURRENT_STACKS) 
    toReturn=[]

    #to copy existing stack
    cpyallStacksJson= json.loads(json.dumps(allStacksJson))

    for dir in dirList:
        if(os.path.isdir(os.path.join(DIR_CURRENT_STACKS,dir))):
            env=[]
            dirTmpStack=os.path.join(DIR_CURRENT_STACKS,dir)
            dirList2 = os.listdir(dirTmpStack) 
            for afilename in dirList2:
                #print(afilename)
                if afilename == ".env":              
                    file = open(os.path.join(dirTmpStack,afilename), "r")
                    alline=file.readlines()
                    print(alline)

                    for aLine in alline:
                        aLine=aLine.strip()
                        if aLine!="" and aLine[0]!="#":
                            splitLine=aLine.split("=")
                            env.append({ "name":splitLine[0], "value":splitLine[1]})
                    print(env)
            
            indLastUnderscore=dir.rfind('_')
            titleFromDir=dir[indLastUnderscore+1:]
            print(titleFromDir)

            for aStack in cpyallStacksJson["stacks"]:
                if aStack["title"].lower()==titleFromDir:
                    aStack["env"]=env
                    aStack["userId"]=dir[:dir.find('_')]
                    print(aStack)
                    break

            toReturn.append(aStack)
    return json.dumps({"stacksInstalled": toReturn})


#get all installed stack
@app.route('/installedStack/custom', method=['OPTIONS', 'GET'])                                             
@auth()
def getAllSintalledStackForAUser():  
    dirList = os.listdir(DIR_CURRENT_STACKS) 
    dirListUser=[]
    toReturn=[]

    idStack=request.json["id"]  

    #to copy existing stack
    cpyallStacksJson= json.loads(json.dumps(allStacksJson))
    print(dirList)
    for dir in dirList:     
        if dir.find(str(idStack))!=-1:
            dirListUser.append(dir)
    print(dirListUser)        
    for dir in dirListUser:
        if(os.path.isdir(os.path.join(DIR_CURRENT_STACKS,dir))):
            env=[]
            dirTmpStack=os.path.join(DIR_CURRENT_STACKS,dir)
            dirList2 = os.listdir(dirTmpStack) 
            print (dirList2)
            for afilename in dirList2:
                #print(afilename)
                if afilename == ".env":              
                    file = open(os.path.join(dirTmpStack,afilename), "r")
                    alline=file.readlines()
                    print(alline)

                    for aLine in alline:
                        aLine=aLine.strip()
                        if aLine!="" and aLine[0]!="#":
                            splitLine=aLine.split("=")
                            env.append({ "name":splitLine[0], "value":splitLine[1]})
                    print(env)
            
            indLastUnderscore=dir.rfind('_')
            titleFromDir=dir[indLastUnderscore+1:]
            print(titleFromDir)

            for aStack in cpyallStacksJson["stacks"]:
                if aStack["title"].lower()==titleFromDir:
                    aStack["env"]=env
                    aStack["userId"]=dir[:dir.find('_')]
                    print(aStack)
                    break

            toReturn.append(aStack)
    return json.dumps(toReturn)
#create stack
@app.route('/create', method=['OPTIONS', 'POST'])
@auth()   
def createStack():   

    allCommandToRunToDeploy=[]
    tmpStack={}  
    idStack=request.json["id"] 
    nbStack=-1
    userid=-1

    if("userid" in request.json ) :  
        userid= request.json["userid"] 

    if("nb_app" in request.json ) :  
        nbStack= request.json["nb_app"] 

    for aStack in allStacksJson["stacks"]:
        if(aStack['id']==idStack):
            tmpStack=aStack
            break
    #print (tmpStack)

    if (len(tmpStack)==0):
        return "not found"

    dirList = os.listdir(DIR_CURRENT_STACKS) 
    nbInstalledApp=0
    for dir in dirList:     
        if userid!=-1 and dir.find(str(userid))!=-1:
            nbInstalledApp=nbInstalledApp+1
    
    print(nbInstalledApp)
    print(nbStack)
    if (nbInstalledApp!=0 and nbStack!=-1 and nbInstalledApp>=nbStack):
        return json.dumps({"info": "too many app"})

    #first arg is the script to use for installion
    allCommandToRunToDeploy.append(tmpStack["installScript"])

    #get env from web    
    for aEnv in request.json["env"]:
        allCommandToRunToDeploy.append(str(aEnv["value"]))
    
    #print (allCommandToRunToDeploy)
    newDirNameStack=str(request.json["userid"])+"_"+str(tmpStack["title"]).lower()

    #copy template
    shutil.copytree(tmpStack["pathLocalDirStack"], os.path.join(DIR_CURRENT_STACKS,newDirNameStack))    

    #launch deploy
    os.chdir(os.path.join(DIR_CURRENT_STACKS,newDirNameStack))
    #change env var
    changeVolumePath(".env","/root/OpenMVPBox/",DIR_CURRENT_STACKS+"/"+str(request.json["userid"])+"_")
    #subprocess.run(allCommandToRunToDeploy, shell=False)
    print(allCommandToRunToDeploy)
    out = check_output(allCommandToRunToDeploy)

    os.chdir(DIR_CURRENT_STACKS) 

    return json.dumps({"info": out.decode("utf-8")})   

@app.route('/createRepo', method=['OPTIONS', 'POST'])
@auth()      
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
@app.route('/delete/<dir_name>', method=['OPTIONS', 'DELETE'])
def deleteStack(dir_name):
    dir_name = dir_name.lower()
    #stoppe docker
    os.chdir(os.path.join(DIR_CURRENT_STACKS,dir_name))
    subprocess.run(["docker-compose","-f","docker-compose-with-traefik.yml", "down"], shell=False)
    os.chdir(DIR_CURRENT_STACKS)

    #remove all volmue
    os.system("docker volume ls | grep '"+str(dir_name)+"' | awk '{print $2}' | xargs docker volume rm")
    
    #delete the dir
    shutil.rmtree(os.path.join(DIR_CURRENT_STACKS,dir_name))
    
    return ""

## not working
@auth()
@route('/download/<dir_name>', method=['OPTIONS', 'GET'])
def download(dir_name):
    os.system(f'tar -cvzf /tmp/{dir_name}.tar.gz /home/ubuntu/stacks/{dir_name}/*', cwd="", shell=True)  
    return static_file(dir_name, root=f'/tmp/{dir_name}.tar.gz', download=dir_name)

@auth()
@route('/addfunc/<id_func>',  method=['OPTIONS', 'GET'])
def setInfoWebhook(id_func):
    url = f'https://discord.com/api/webhooks/{url_1}/{url_2}'   
    
    data = {
        "content" : f'add func {id_func}',
        "username" : "custom username"
    }
    result = requests.post(url, json = data)

    try:
        result.raise_for_status()
    except requests.exceptions.HTTPError as err:
        print(err)
    else:
        print("Payload delivered successfully, code {}.".format(result.status_code))
    return ""

@auth()
@route('/monitor',  method=['OPTIONS', 'GET'])
def monitor():

    load=psutil.getloadavg()

    return_dict = {'disk_usage': psutil.disk_usage('/')[3],
    'load_0': load[0],
    'load_1': load[1],
    'load_2': load[2],
    'cpu': psutil.cpu_percent(interval=1),
    'ram': psutil.virtual_memory().percent
    }  

    return json.dumps(return_dict)


if __name__ == '__main__':
    #set apiKey
    readApkiKey("/root/OpenMVPBox/apiKey")

    #run service
    bottle.run(host="@ip", port=9080)
    #bottle.run(host="0.0.0.0", port=9081)

