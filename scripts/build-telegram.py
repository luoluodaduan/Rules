import os
import requests

def get_telegram(url, retries=3):
    if url.startswith('http'):
        for i in range(retries):
            try:
                res = requests.get(url, timeout=10)
                res.raise_for_status()
                return res.text.splitlines()
            except requests.RequestException as e:
                if i == retries - 1:
                    print(f"网络请求失败 ({url}): {e}")
        return []
    else:
        try:
            with open(url, 'r', encoding='utf-8') as f:
                return f.read().splitlines()
        except Exception as e:
            print(f"读取本地文件失败 ({url}): {e}")
            return []

telegram_urls = [
    "https://core.telegram.org/resources/cidr.txt"
]

if __name__ == "__main__":
    telegram = set()
    for url in telegram_urls:
        telegram.update(get_telegram(url))
    with open(os.getcwd() + "/dist/telegram1.txt", "w", encoding="utf-8") as f1, \
        open(os.getcwd() + "/dist/telegram2.txt", "w", encoding="utf-8") as f2:
        for line in sorted(telegram):
            line = line.strip()
            if line and not line.startswith(("#", "!", "[")):
                ipaddr = (line.replace("\t", "").replace(" ", ""))
                try:
                    f1.write(f"IP-CIDR,{ipaddr},PROXY,no-resolve\n")
                    f2.write(f"  - '{ipaddr}'\n")
                except Exception as e:
                    print(f"运行出错: {e}")
