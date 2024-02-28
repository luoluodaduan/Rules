import os
import requests

def get_rules2(url):
    res = requests.get(url)
    if res.status_code != 200:
        raise Exception("Connect error")
    return res.text.split("\n")

rules2_urls = []
rules2_urls.append("https://raw.githubusercontent.com/easylist/easylistchina/master/easylistchina.txt")
rules2_urls.append("https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-adguard.txt")
# rules2_urls.append('https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-annoyance.txt')
# rules2_urls.append('https://raw.githubusercontent.com/LightAPIs/adblock_rules/master/adblock_rules.txt')
# rules2_urls.append('https://raw.githubusercontent.com/Noyllopa/NoAppDownload/master/NoAppDownload.txt')
# rules2_urls.append('https://raw.githubusercontent.com/xiaoxing1748/adblock_rules/main/bilibili.txt')
# rules2_urls.append('https://raw.githubusercontent.com/xiaoxing1748/adblock_rules/main/others.txt')
# rules2_urls.append('https://raw.githubusercontent.com/yutian88881/PUA-Block/master/PUA-Block.txt')
# rules2_urls.append('https://raw.githubusercontent.com/Zereao/AD_Rules/master/Program%20Engineer%20List.txt')

if __name__ == "__main__":
    rules2 = set()
    for url in rules2_urls:
        rules = set(get_rules2(url))
        rules2 = rules2.union(rules)
    rules2 = list(rules2)
    rules2.sort()
    rules2_file = open(os.getcwd() + "/dist/rules2.txt", mode="w", encoding="utf-8")
    for line in rules2:
        if not line.startswith(("#", "!", "！", "[")) and len(line) > 0:
            rules2_file.write("%s\n" % line.replace("\r", ""))
    rules2_file.close()
