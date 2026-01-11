#!/bin/sh

sort -uf dist/apple1.txt | grep -vE '^(\s*)$' >gen/apple.txt
sed -r "s/'\./'+\./" dist/apple2.txt | sort -uf | grep -vE '^(\s*)$' | sed -e '1s/^/payload:\n/' >coo/apple.yaml

sort -uf dist/cnip1.txt | grep -vE '^(\s*)$' >gen/cnip.txt
sort -uf dist/cnip2.txt | grep -vE '^(\s*)$' | sed -e '1s/^/payload:\n/' >coo/cnip.yaml

P_name='blogspot|discord|facebook|flickr|google|instagram|netflix|pinterest|porn|telegram|twitch|twitter|whatsapp|wikileaks|wikipedia|yahoo|youtube'
grep -vE "$P_name" dist/direct1.txt | grep -vE '[a-zA-Z0-9]\.cn$' | sort -uf | grep -vE '^(\s*)$' >gen/direct.txt
grep -vE "$P_name" dist/direct2.txt | grep -vE "[a-zA-Z0-9]\.cn'$" | sed -r "s/'\./'+\./" | sort -uf | grep -vE '^(\s*)$' | sed -e '1s/^/payload:\n/' >coo/direct.yaml
cat dist/direct3.txt | grep -vE "$P_name" | grep -vE '[a-zA-Z0-9]\.cn/([0-9]{1,3}\.){3}[0-9]{1,3}$' | sed -r 's|server=/\.|server=/|' | sort -uf | grep -vE '^(\s*)$' >fan/dnsmasqCN.txt
grep -vE "$P_name" dist/direct1.txt | grep -vE '[a-zA-Z0-9]\.cn$|jsdelivr\.|gh-proxy\.' | sed -r 's/^\.//' | sort -uf | grep -vE '^(\s*)$' >fan/smartdnsCN.txt

sort -uf dist/proxy1.txt | grep -vE '^(\s*)$' >gen/proxy.txt
sort -uf dist/proxy2.txt | grep -vE '^(\s*)$' | sed -e '1s/^/payload:\n/' >coo/proxy.yaml

sort -u dist/adguard1.txt | grep -vE '^(\s*)$' >fan/adguard.txt
grep -vE 'adservice|advertising|guanggao' dist/reject1.txt | sort -uf | grep -vE '^(\s*)$' >gen/reject.txt
grep -vE 'adservice|advertising|guanggao' dist/reject2.txt | sort -uf | grep -vE '^(\s*)$' | sed -e '1s/^/payload:\n/' >coo/reject.yaml
sort -uf dist/reject3.txt | grep -vE '^(\s*)$' >fan/dnsmasqAd.txt
sort -uf dist/reject4.txt | grep -vE '^(\s*)$' >fan/smartdnsAd.txt

sort -uf dist/telegram1.txt | grep -vE '^(\s*)$' >temp/telegram.txt
sort -uf dist/telegram2.txt | grep -vE '^(\s*)$' | sed -e '1s/^/payload:\n/' >coo/telegram.yaml
