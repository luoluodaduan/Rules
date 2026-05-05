#!/bin/sh

KEYWORDS1='blogspot|discord|facebook|flickr|google|instagram|netflix|pinterest|porn|telegram|twitch|twitter|whatsapp|wikileaks|wikipedia|yahoo|youtube'
KEYWORDS2="\.cn'?$|\.xn--fiqs8s'?$|\.hao123|\.(baidu|iqiyi|sina|weibo|youku|apple|icloud|itunes|microsoft|windows)\."
KEYWORDS3='adservice|advertisement|advertising|commercial|guanggao'

grep -vE '^(\s*)$' dist/cnip1.txt | sort -uf >gen/cnip.txt
echo "payload:" >coo/cnip.yaml
grep -vE '^(\s*)$' dist/cnip2.txt | sort -uf >>coo/cnip.yaml

grep -vE "(${KEYWORDS1})|[a-zA-Z0-9]\.cn$|^(\s*)$" dist/direct1.txt | sed -r 's/\.+/./g' | sort -uf >gen/direct.txt
echo "payload:" >coo/direct.yaml
grep -vE "(${KEYWORDS1})|[a-zA-Z0-9]\.cn'$|^(\s*)$" dist/direct2.txt | sed -r 's/\.+/./g' | sort -uf >>coo/direct.yaml
cat dist/direct3.txt | grep -vE "(${KEYWORDS1})|[a-zA-Z0-9]\.cn/|^(\s*)$" | sed -r 's|server=/\.+|server=/|g' | sort -uf >fan/dnsmasqCN.txt
grep -vE "(${KEYWORDS1})|[a-zA-Z0-9]\.cn$|^(\s*)$|\.jsdelivr\.|\.gh-proxy\." dist/direct1.txt | sed -r 's/^\.+//g' | sort -uf >fan/smartdnsCN.txt

grep -vE "(${KEYWORDS1})|(${KEYWORDS2})|^(\s*)$" dist/proxy1.txt | sed -r 's/\.+/./g' | sort -uf >gen/proxy.txt
echo "payload:" >coo/proxy.yaml
grep -vE "(${KEYWORDS1})|(${KEYWORDS2})|^(\s*)$" dist/proxy2.txt | sed -r 's/\.+/./g' | sort -uf >>coo/proxy.yaml

grep -vE '^(\s*)$' dist/adguard1.txt | sed -r 's/ +/ /g' | sort -u >fan/adguard.txt

grep -vE "(${KEYWORDS3})|^(\s*)$" dist/reject1.txt | sed -r 's/\.+/./g' | sort -uf >gen/reject.txt
echo "payload:" >coo/reject.yaml
grep -vE "(${KEYWORDS3})|^(\s*)$" dist/reject2.txt | sed -r 's/\.+/./g' | sort -uf >>coo/reject.yaml
grep -vE '^(\s*)$' dist/reject3.txt | sed -r 's|address=/\.+|address=/|g' | sort -uf >fan/dnsmasqAd.txt
grep -vE '^(\s*)$' dist/reject1.txt | sed -r 's/^\.+//g' | sort -uf >fan/smartdnsAd.txt

grep -vE '^(\s*)$' dist/telegram1.txt | sort -uf >temp/telegram.txt
echo "payload:" >coo/telegram.yaml
grep -vE '^(\s*)$' dist/telegram2.txt | sort -uf >>coo/telegram.yaml
