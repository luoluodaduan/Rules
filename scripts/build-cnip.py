import os
import requests

def get_cnip(url, retries=3):
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

cnip_urls = [
    "https://ispip.clang.cn/all_cn_cidr.txt",
    "https://ispip.clang.cn/all_cn_ipv6.txt"
]

if __name__ == "__main__":
    cnip = set()
    for url in cnip_urls:
        cnip.update(get_cnip(url))
    with open(os.getcwd() + "/dist/cnip1.txt", "w", encoding="utf-8") as f1, \
        open(os.getcwd() + "/dist/cnip2.txt", "w", encoding="utf-8") as f2:
        for line in sorted(cnip):
            line = line.strip()
            if line and not line.startswith(("#", "!", "[")):
                ipaddr = (line.replace("\t", "").replace(" ", ""))
                try:
                    f1.write(f"{ipaddr}\n")
                    f2.write(f"  - '{ipaddr}'\n")
                except Exception as e:
                    print(f"运行出错: {e}")
