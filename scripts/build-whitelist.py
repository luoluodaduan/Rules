import os
import requests

def get_whitelist(url):
    res = requests.get(url)
    if res.status_code != 200:
        raise Exception("Connect error")
    return res.text.split("\n")

whitelist_urls = []
whitelist_urls.append("https://raw.githubusercontent.com/privacy-protection-tools/dead-horse/master/anti-ad-white-list.txt")

if __name__ == "__main__":
    whitelist = set()
    for url in whitelist_urls:
        rules = set(get_whitelist(url))
        whitelist = whitelist.union(rules)
    whitelist = list(whitelist)
    whitelist.sort()
    whitelist_file = open(os.getcwd() + "/dist/whitelist1.txt", mode="w", encoding="utf-8")
    for line in whitelist:
        if not line.startswith(("#", "!", "！", "[")) and len(line) > 0:
            whitelist_file.write(".%s\n" % line.replace("\r", "").replace(" ", ""))
    whitelist_file.close()
