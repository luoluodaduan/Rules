import os
import requests

def get_cnip(url):
    res = requests.get(url)
    if res.status_code != 200:
        raise Exception("Connect error")
    return res.text.split("\n")

cnip_urls = []
cnip_urls.append("https://raw.githubusercontent.com/luoluodaduan/Rules/main/temp/cnipv4.txt")
cnip_urls.append("https://raw.githubusercontent.com/luoluodaduan/Rules/main/temp/cnipv6.txt")

if __name__ == "__main__":
    cnip = set()
    for url in cnip_urls:
        rules = set(get_cnip(url))
        cnip = cnip.union(rules)
    cnip = list(cnip)
    cnip.sort()
    cnip_file = open(os.getcwd() + "/dist/cnip2.txt", mode="w", encoding="utf-8")
    for line in cnip:
        if not line.startswith(("#", "!", "！", "[")) and len(line) > 0:
            cnip_file.write("  - '%s'\n" % line.replace(" ", "").replace("\r", ""))
    cnip_file.close()
