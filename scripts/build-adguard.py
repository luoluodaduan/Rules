import os
import requests

def get_adguard(url, retries=3):
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

adguard_urls = [
    "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_15_DnsFilter/filter.txt",
    "https://raw.githubusercontent.com/curbengh/malware-filter/gh-pages/phishing-filter-agh.txt",
    "https://raw.githubusercontent.com/curbengh/malware-filter/gh-pages/urlhaus-filter-agh-online.txt",
    "https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt",
    "https://raw.githubusercontent.com/TG-Twilight/AWAvenue-Ads-Rule/refs/heads/main/AWAvenue-Ads-Rule.txt"
]

if __name__ == "__main__":
    adguard = set()
    for url in adguard_urls:
        adguard.update(get_adguard(url))
    with open(os.getcwd() + "/dist/adguard1.txt", "w", encoding="utf-8") as f1:
        for line in sorted(adguard):
            line = line.strip()
            if line and not line.startswith(("#", "!", "[")):
                domain = line.replace("\t", " ")
                try:
                    f1.write(f"{domain}\n")
                except Exception as e:
                    print(f"运行出错: {e}")
