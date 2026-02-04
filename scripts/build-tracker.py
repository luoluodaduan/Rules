import os
import requests

def get_tracker(url, retries=3):
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

tracker_urls = [
    "https://cf.trackerslist.com/all.txt",
    "https://cf.trackerslist.com/best.txt",
    "https://cf.trackerslist.com/http.txt"
]

if __name__ == "__main__":
    tracker = set()
    for url in tracker_urls:
        tracker.update(get_tracker(url))
    with open(os.getcwd() + "/fan/tracker.txt", "w", encoding="utf-8") as f1:
        for line in sorted(tracker):
            line = line.strip()
            if line and not line.startswith(("#", "!", "[")):
                domain = (line.replace("\t", "").replace(" ", ""))
                try:
                    f1.write(f"{domain}\n\n")
                except Exception as e:
                    print(f"运行出错: {e}")
