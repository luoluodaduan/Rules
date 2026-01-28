#!/bin/sh

KEYWORDS1='blogspot|discord|facebook|flickr|google|instagram|netflix|pinterest|porn|telegram|twitch|twitter|whatsapp|wikileaks|wikipedia|yahoo|youtube'
KEYWORDS2="\.cn'?$|\.xn--fiqs8s'?$|\.hao123|\.(baidu|iqiyi|sina|weibo|youku|apple|icloud|itunes|microsoft|windows)\."
KEYWORDS3='adservice|advertisement|advertising|commercial|guanggao'

grep -vE '^(\s*)$' dist/apple1.txt | sort -uf >gen/apple.txt
grep -vE '^(\s*)$' dist/apple2.txt | sed -r "s/'\./'+\./" | sort -uf | sed -e '1s/^/payload:\n/' >coo/apple.yaml

grep -vE '^(\s*)$' dist/cnip1.txt | sort -uf >gen/cnip.txt
grep -vE '^(\s*)$' dist/cnip2.txt | sort -uf | sed -e '1s/^/payload:\n/' >coo/cnip.yaml

grep -vE "($KEYWORDS1)|[a-zA-Z0-9]\.cn$|^(\s*)$" dist/direct1.txt | sort -uf >gen/direct.txt
grep -vE "($KEYWORDS1)|[a-zA-Z0-9]\.cn'$|^(\s*)$" dist/direct2.txt | sed -r "s/'\./'+\./" | sort -uf | sed -e '1s/^/payload:\n/' >coo/direct.yaml
cat dist/direct3.txt | grep -vE "($KEYWORDS1)|[a-zA-Z0-9]\.cn/([0-9]{1,3}\.){3}[0-9]{1,3}$|^(\s*)$" | sed -r 's|server=/\.|server=/|' | sort -uf >fan/dnsmasqCN.txt
grep -vE "($KEYWORDS1)|[a-zA-Z0-9]\.cn$|^(\s*)$|\.jsdelivr\.|\.gh-proxy\." dist/direct1.txt | sed -r 's/^\.//' | sort -uf >fan/smartdnsCN.txt

grep -vE "($KEYWORDS1)|($KEYWORDS2)|^(\s*)$" dist/proxy1.txt | sort -uf >gen/proxy.txt
grep -vE "($KEYWORDS1)|($KEYWORDS2)|^(\s*)$" dist/proxy2.txt | sort -uf | sed -e '1s/^/payload:\n/' >coo/proxy.yaml

grep -vE '^(\s*)$' dist/adguard1.txt | sed -r 's/ +/ /g' | sort -u >fan/adguard.txt

grep -vE "($KEYWORDS3)|^(\s*)$" dist/reject1.txt | sort -uf >gen/reject.txt
grep -vE "($KEYWORDS3)|^(\s*)$" dist/reject2.txt | sort -uf | sed -e '1s/^/payload:\n/' >coo/reject.yaml
grep -vE '^(\s*)$' dist/reject3.txt | sort -uf >fan/dnsmasqAd.txt
grep -vE '^(\s*)$' dist/reject4.txt | sort -uf >fan/smartdnsAd.txt

grep -vE '^(\s*)$' dist/telegram1.txt | sort -uf >temp/telegram.txt
grep -vE '^(\s*)$' dist/telegram2.txt | sort -uf | sed -e '1s/^/payload:\n/' >coo/telegram.yaml
