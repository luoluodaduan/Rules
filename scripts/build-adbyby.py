import os
import requests

def get_adbyby(url):
    res = requests.get(url)
    if res.status_code != 200:
        raise Exception("Connect error")
    return res.text.split("\n")

adbyby_urls = []
adbyby_urls.append("https://raw.githubusercontent.com/easylist/easylistchina/master/easylistchina.txt")
adbyby_urls.append("https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-adguard.txt")
# adbyby_urls.append('https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-annoyance.txt')
# adbyby_urls.append('https://raw.githubusercontent.com/LightAPIs/adblock_rules/master/adblock_rules.txt')
# adbyby_urls.append('https://raw.githubusercontent.com/Noyllopa/NoAppDownload/master/NoAppDownload.txt')
# adbyby_urls.append('https://raw.githubusercontent.com/xiaoxing1748/adblock_rules/main/bilibili.txt')
# adbyby_urls.append('https://raw.githubusercontent.com/xiaoxing1748/adblock_rules/main/others.txt')
# adbyby_urls.append('https://raw.githubusercontent.com/yutian88881/PUA-Block/master/PUA-Block.txt')
# adbyby_urls.append('https://raw.githubusercontent.com/Zereao/AD_Rules/master/Program%20Engineer%20List.txt')

if __name__ == "__main__":
    adbyby = set()
    for url in adbyby_urls:
        rules = set(get_adbyby(url))
        adbyby = adbyby.union(rules)
    adbyby = list(adbyby)
    adbyby.sort()
    adbyby_file = open(os.getcwd() + "/dist/adbyby1.txt", mode="w", encoding="utf-8")
    for line in adbyby:
        if not line.startswith(("#", "!", "！", "[")) and len(line) > 0:
            adbyby_file.write("%s\n" % line.replace("  ", " ").replace("\r", ""))
    adbyby_file.close()
