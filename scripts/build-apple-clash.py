import os
import requests

def get_apple(url):
    res = requests.get(url)
    if res.status_code != 200:
        raise Exception("Connect error")
    return res.text.split("\n")

apple_urls = []
apple_urls.append("https://raw.githubusercontent.com/v2fly/domain-list-community/refs/heads/release/apple.txt")
apple_urls.append("https://raw.githubusercontent.com/v2fly/domain-list-community/refs/heads/release/icloud.txt")
apple_urls.append("https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf")

if __name__ == "__main__":
    apple = set()
    for url in apple_urls:
        rules = set(get_apple(url))
        apple = apple.union(rules)
    apple = list(apple)
    apple.sort()
    apple_file = open(os.getcwd() + "/dist/apple2.txt", mode="w", encoding="utf-8")
    for line in apple:
        if not line.startswith(("#", "!", "！", "[","regexp")) and not line.endswith(("@ads")) and len(line) > 0:
            apple_file.write("  - '%s'\n" % line.replace("server=/", "").replace("/114.114.114.114", "").replace("domain:", ".").replace("full:", "").replace(":@cn", "").replace("\r", "").replace(" ", ""))
    apple_file.close()
