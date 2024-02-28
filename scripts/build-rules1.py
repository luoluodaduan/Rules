import os
import requests

def get_rules1(url):
    res = requests.get(url)
    if res.status_code != 200:
        raise Exception("Connect error")
    return res.text.split("\n")

rules1_urls = []
rules1_urls.append("https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_15_DnsFilter/filter.txt")
rules1_urls.append("https://raw.githubusercontent.com/curbengh/malware-filter/gh-pages/phishing-filter-agh.txt")
rules1_urls.append("https://raw.githubusercontent.com/curbengh/malware-filter/gh-pages/urlhaus-filter-agh-online.txt")
rules1_urls.append("https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt")
# rules1_urls.append('https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/minority-mv.txt')
# rules1_urls.append('https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt')

if __name__ == "__main__":
    rules1 = set()
    for url in rules1_urls:
        rules = set(get_rules1(url))
        rules1 = rules1.union(rules)
    rules1 = list(rules1)
    rules1.sort()
    rules1_file = open(os.getcwd() + "/dist/rules1.txt", mode="w", encoding="utf-8")
    for line in rules1:
        if not line.startswith(("#", "!", "！", "[")) and len(line) > 0:
            rules1_file.write("%s\n" % line.replace("\r", ""))
    rules1_file.close()
