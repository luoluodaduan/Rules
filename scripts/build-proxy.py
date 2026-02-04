import os
import requests
from tld import get_tld

def get_proxy(url, retries=3):
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

proxy_urls = [
    "./dist/gfw.txt"
]

if __name__ == "__main__":
    proxy = set()
    for url in proxy_urls:
        proxy.update(get_proxy(url))
    with open(os.getcwd() + "/dist/proxy1.txt", "w", encoding="utf-8") as f1, \
        open(os.getcwd() + "/dist/proxy2.txt", "w", encoding="utf-8") as f2:
        for line in sorted(proxy):
            line = line.strip()
            if line and not line.startswith(("#", "!", "[")):
                domain = (line.replace("\t", "").replace(" ", ""))
                try:
                    result = get_tld(domain, as_object=True, fix_protocol=True)
                    root_domain = result.fld
                    f1.write(f".{root_domain}\n")
                    f2.write(f"  - '+.{root_domain}'\n")
                except Exception as e:
                    print(f"运行出错: {e}")
