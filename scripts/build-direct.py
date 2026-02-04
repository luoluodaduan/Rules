import os
import requests

def get_direct(url, retries=3):
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

direct_urls = [
    "./temp/direct_custom.txt",
    "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf",
    "https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/direct.txt"
]

if __name__ == "__main__":
    direct = set()
    for url in direct_urls:
        direct.update(get_direct(url))
    with open(os.getcwd() + "/dist/direct1.txt", "w", encoding="utf-8") as f1, \
        open(os.getcwd() + "/dist/direct2.txt", "w", encoding="utf-8") as f2, \
        open(os.getcwd() + "/dist/direct3.txt", "w", encoding="utf-8") as f3, \
        open(os.getcwd() + "/dist/direct4.txt", "w", encoding="utf-8") as f4:
        for line in sorted(direct):
            line = line.strip()
            if line and not line.startswith(("#", "!", "[")):
                domain = (line.replace("\t", "").replace(" ", "").replace("server=/", "").replace("/114.114.114.114", ""))
                try:
                    f1.write(f".{domain}\n")
                    f2.write(f"  - '+.{domain}'\n")
                    f3.write(f"server=/{domain}/223.5.5.5\n")
                    f4.write(f"server=/{domain}/119.29.29.29\n")
                except Exception as e:
                    print(f"运行出错: {e}")
