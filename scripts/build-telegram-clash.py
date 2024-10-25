import os
import requests

def get_telegram(url):
    res = requests.get(url)
    if res.status_code != 200:
        raise Exception("Connect error")
    return res.text.split("\n")

telegram_urls = []
telegram_urls.append("https://core.telegram.org/resources/cidr.txt")

if __name__ == "__main__":
    telegram = set()
    for url in telegram_urls:
        rules = set(get_telegram(url))
        telegram = telegram.union(rules)
    telegram = list(telegram)
    telegram.sort()
    telegram_file = open(os.getcwd() + "/dist/telegram2.txt", mode="w", encoding="utf-8")
    for line in telegram:
        if not line.startswith(("#", "!", "！", "[")) and len(line) > 0:
            telegram_file.write("  - '%s'\n" % line.replace(" ", "").replace("\r", ""))
    telegram_file.close()
