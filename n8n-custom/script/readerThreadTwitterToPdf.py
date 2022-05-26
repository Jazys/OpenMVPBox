from pathlib import Path
import sys

from weasyprint import HTML

import requests
from bs4 import BeautifulSoup


tweetId="1472976784547270661"

r = requests.get('https://threadreaderapp.com/thread/'+str(tweetId)+'.html')
soup = BeautifulSoup(r.content.decode('utf-8', errors="replace"), "html.parser")




#to get title
title=soup.find("meta", property="og:description")
title=title["content"]

tmp=soup.find("div",attrs={"class":"mb-2 d-flex align-items-center"})

if tmp!=None :
    new_title = soup.new_tag("center")
    new_titleh = soup.new_tag("h2")
    new_titleh.string = title[0:80]+" ...."
    new_title.append(new_titleh)
    tmp.insert_before(new_title)


soup.find("title").string.replace_with("Mega Service")
soup.nav.decompose()

if soup.find("div",attrs={"class":"overlay-no-js","id":"share_this"})!= None:
    soup.find("div",attrs={"class":"overlay-no-js","id":"share_this"}).decompose()

if soup.find("div",attrs={"class":"hide-mobile"})!=None:
    soup.find("div",attrs={"class":"hide-mobile"}).decompose()

if soup.find("div",attrs={"class":"row mb-4"})!=None:
    soup.find("div",attrs={"class":"row mb-4"}).decompose()

if soup.find("div",attrs={"class":"scrolly"}) != None :
    soup.find("div",attrs={"class":"scrolly"}).decompose()

if soup.find("div",attrs={"class":"text-right small"})!=None :
    soup.find("div",attrs={"class":"text-right small"}).decompose()
if soup.find("div",attrs={"class":"web-intent"})!=None :
    soup.find("div",attrs={"class":"web-intent"}).decompose()
if soup.find("div",attrs={"class":"text-center"})!=None :
    soup.find("div",attrs={"class":"text-center"}).decompose()
if soup.find("div",attrs={"class":"container pb-5"})!=None :
    soup.find("div",attrs={"class":"container pb-5"}).decompose()
if soup.find("div",attrs={"class":"background-blue entry-support hide-premium pd-4 hide-redundant"})!=None :
    soup.find("div",attrs={"class":"background-blue entry-support hide-premium pd-4 hide-redundant"}).decompose()
if soup.find("div",attrs={"class":"sharingfooter"})!=None :
    soup.find("div",attrs={"class":"sharingfooter"}).decompose()
if soup.find("div",attrs={"class":"overlay-no-js dark","id":"refresh_thread"})!=None :
    soup.find("div",attrs={"class":"overlay-no-js dark","id":"refresh_thread"}).decompose()


if soup.find("div",attrs={"class":"text-center"})!=None :
    soup.find("div",attrs={"class":"text-center"}).decompose()

if soup.find("div",attrs={"class":"overlay-no-js","id":"my_authors"})!=None :
    soup.find("div",attrs={"class":"overlay-no-js","id":"my_authors"}).decompose()


soup.find("footer").decompose()


for p in soup.find_all('span', class_="entity-image"):
    p.insert_before(soup.new_tag("br"))

with open('html_'+str(tweetId)+".html", 'w', encoding='utf8') as fp:
    fp.write(soup.prettify().replace("data-src","hdatasrc").replace("hdatasrc","src").replace("src=\"/images/1px.png\"","width=\"80%\" height=\"auto\""))

def makepdf(html):
    """Generate a PDF file from a string of HTML."""
    htmldoc = HTML(string=html, base_url="")
    return htmldoc.write_pdf(presentational_hints=True)


def run():
    """Command runner."""
    infile ="html_"+str(tweetId)+".html"
    outfile = "/share-view-only/pdf_"+str(tweetId)+".pdf"
    html = Path(infile).read_text()
    pdf = makepdf(html)
    Path(outfile).write_bytes(pdf)


if __name__ == "__main__":
    run()
