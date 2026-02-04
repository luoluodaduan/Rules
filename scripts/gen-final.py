import os
import re
import time

def get_from_file(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()

values = {
    "build_time": time.strftime("%Y-%m-%d %H:%M:%S"),
    "general": get_from_file(os.getcwd() + "/temp/general.txt"),
    "private": get_from_file(os.getcwd() + "/temp/private.txt"),
    "custom": get_from_file(os.getcwd() + "/temp/custom.txt"),
    "tiktok": get_from_file(os.getcwd() + "/temp/tiktok.txt"),
    "telegram": get_from_file(os.getcwd() + "/temp/telegram.txt"),
    "rewrite": get_from_file(os.getcwd() + "/temp/rewrite.txt"),
    "rewriteplus": get_from_file(os.getcwd() + "/temp/rewriteplus.txt"),
}

def gen_file(name):
    with open(os.getcwd() + f"/template/{name}-template.conf", "r", encoding="utf-8") as f:
        template = f.read()
    marks = re.findall(r"{{(.+?)}}", template)
    for mark in marks:
        if mark in values:
            template = template.replace("{{" + mark + "}}", values[mark])
    with open(os.getcwd() + f"/gen/{name}.conf", "w", encoding="utf-8") as f:
        f.write(template)

file_names = [
    "white-ad",
    "white-ad-tiktok",
    "white-tiktok",
]

if __name__ == "__main__":
    for name in file_names:
        gen_file(name)
