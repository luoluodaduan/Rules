import os
import requests

def get_apple(url, retries=3):
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

apple_urls = [
    "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf",
    "https://raw.githubusercontent.com/v2fly/domain-list-community/release/apple.txt",
    "https://raw.githubusercontent.com/v2fly/domain-list-community/release/icloud.txt"
]

if __name__ == "__main__":
    apple = set()
    for url in apple_urls:
        apple.update(get_apple(url))
    with open(os.getcwd() + "/dist/apple1.txt", "w", encoding="utf-8") as f1, \
        open(os.getcwd() + "/dist/apple2.txt", "w", encoding="utf-8") as f2:
        for line in sorted(apple):
            line = line.strip()
            if line and not line.startswith(("#", "!", "[")) and not line.endswith("@ads"):
                domain = (line.replace("\t", "").replace(" ", "").replace("server=/", "").replace("/114.114.114.114", "").replace("domain:", ".").replace("full:", "").replace(":@cn", ""))
                try:
                    f1.write(f"{domain}\n")
                    f2.write(f"  - '{domain}'\n")
                except Exception as e:
                    print(f"运行出错: {e}")
