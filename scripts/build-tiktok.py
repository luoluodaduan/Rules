import os
import requests

def get_tiktok(url, retries=3):
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

tiktok_urls = [
    "https://raw.githubusercontent.com/Semporia/TikTok-Unlock/master/Shadowrocket/TikTok.list"
]

if __name__ == "__main__":
    tiktok = set()
    for url in tiktok_urls:
        tiktok.update(get_tiktok(url))
    with open(os.getcwd() + "/temp/tiktok.txt", "w", encoding="utf-8") as f1:
        for line in sorted(tiktok):
            line = line.strip()
            if line and not line.startswith(("#", "!", "[")):
                domain = (line.replace("\t", "").replace(" ", ""))
                try:
                    f1.write(f"{domain},PROXY\n")
                except Exception as e:
                    print(f"运行出错: {e}")
