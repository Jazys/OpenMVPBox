import csv
from urllib.request import Request, urlopen
from datetime import date
from time import sleep
from bs4 import BeautifulSoup as soup
import sys

#etherscan base url
etherscan_base_url="https://etherscan.io/"
#address list to lookup labels for
addresslist=[]
#labels dictionary
labels={}
# fake UA to spoof a real browser (etherscan 403s requests from bots)
useragent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36'"
# delay in seconds to throttle the scraping attempts
delay=.1



addresslist.append(sys.argv[1])
for a in addresslist:
    url=etherscan_base_url+"address/"+a
    req = Request(url, headers={'User-Agent':useragent})
    response = urlopen(req, timeout=10).read()
    response_close = urlopen(req, timeout=10).close()
    page_soup = soup(response, "html.parser")
    ntspan=page_soup.find(attrs={"title":"Public Name Tag (viewable by anyone)"})
    #print("Found span -> ", str(ntspan))
    nt=""
    if (ntspan): nt=ntspan.contents[0]
    #print("Name Tag -> ", str(nt))
    labels["Name"]=nt
    sleep(delay)

for a in addresslist:
    url=etherscan_base_url+"token/"+a
    req = Request(url, headers={'User-Agent':useragent})
    response = urlopen(req, timeout=10).read()
    response_close = urlopen(req, timeout=10).close()
    page_soup = soup(response, "html.parser")
    ntspan=page_soup.find("div", {"class": "mr-3"}) #  ntspan=page_soup.find("div", {"id": "ContentPlaceHolder1_trDecimals"})
    #print("Found span -> ", str(ntspan))
    nt=""
    if (ntspan): nt=ntspan.contents[0]
    #print("Holder -> ", str(nt))
    labels["Holder"]=nt
    sleep(delay)

print (labels)