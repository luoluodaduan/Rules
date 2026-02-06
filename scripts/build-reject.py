import os
import requests

def get_reject(url, retries=3):
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

reject_urls = [
    "https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-surge2.txt",
    "https://raw.githubusercontent.com/TG-Twilight/AWAvenue-Ads-Rule/main/Filters/AWAvenue-Ads-Rule-Surge.list"
]

if __name__ == "__main__":
    reject = set()
    for url in reject_urls:
        reject.update(get_reject(url))
    with open(os.getcwd() + "/dist/reject1.txt", "w", encoding="utf-8") as f1, \
        open(os.getcwd() + "/dist/reject2.txt", "w", encoding="utf-8") as f2, \
        open(os.getcwd() + "/dist/reject3.txt", "w", encoding="utf-8") as f3:
        for line in sorted(reject):
            line = line.strip()
            if line and not line.startswith(("#", "!", "[")):
                domain = (line.replace("\t", "").replace(" ", ""))
                try:
                    f1.write(f".{domain}\n")
                    f2.write(f"  - '+.{domain}'\n")
                    f3.write(f"address=/{domain}/\n")
                except Exception as e:
                    print(f"运行出错: {e}")
