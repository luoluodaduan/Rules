import os
import requests

def get_reject(url):
    res = requests.get(url)
    if res.status_code != 200:
        raise Exception("Connect error")
    return res.text.split("\n")

reject_urls = []
reject_urls.append("https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-surge2.txt")

if __name__ == "__main__":
    reject = set()
    for url in reject_urls:
        rules = set(get_reject(url))
        reject = reject.union(rules)
    reject = list(reject)
    reject.sort()
    reject_file = open(os.getcwd() + "/dist/reject1.txt", mode="w", encoding="utf-8")
    for line in reject:
        if not line.startswith(("#", "!", "！", "[")) and len(line) > 0:
            reject_file.write("%s\n" % line.replace(" ", "").replace("\r", ""))
    reject_file.close()
