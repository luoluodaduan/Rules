#!/bin/sh

rm -rf fan/[0-9].json

curl -o- --connect-timeout 10 --retry 3 "https://raw.githubusercontent.com/n3rddd/N3RD/master/JN/lem.json" | sed 's/\r/\n/g' | grep -vE '^(\s*)//|^(\s*)$' >dist/1.json
curl -o- --connect-timeout 10 --retry 3 "https://raw.githubusercontent.com/xyq254245/xyqonlinerule/main/XYQTVBox.json" | sed 's/\r/\n/g' | grep -vE '^(\s*)//|^(\s*)$' >dist/2.json
curl -o- --connect-timeout 10 --retry 3 "https://raw.githubusercontent.com/yoursmile66/TVBox/main/XC.json" | sed 's/\r/\n/g' | grep -vE '^(\s*)//|^(\s*)$' >dist/3.json
curl -o- --connect-timeout 10 --retry 3 "https://raw.githubusercontent.com/ne7359/tvurl/main/0821.json" | sed 's/\r/\n/g' | grep -vE '^(\s*)//|^(\s*)$' >dist/4.json
curl -o- --connect-timeout 10 --retry 3 "https://raw.githubusercontent.com/ne7359/tvurl/main/xiaosa/api.json" | sed 's/\r/\n/g' | grep -vE '^(\s*)//|^(\s*)$' >dist/5.json
curl -o- --connect-timeout 10 --retry 3 "https://raw.githubusercontent.com/wanganni/yinshiyuan/main/tvbox18.json" | sed 's/\r/\n/g' | grep -vE '^(\s*)//|^(\s*)$' >dist/6.json
find dist -name '6.json' | xargs -r perl -pi -e "s/\'/\"/g"

find dist -name '[0-9].json' | xargs -r perl -pi -e 's|\t| |g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|　| |g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|ㅤ| |g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|http([s]?):(/{1,4})([^/]+)|http$1://$3|g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|"http([s]?)://([^"]+)(?<!:)//([^"]*)"|"http$1://$2/$3"|g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|"http([s]?)://([^"]+)(?<!:)//([^"]*)"|"http$1://$2/$3"|g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|(["=])(\.{2,3})/|$1./|g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|"\./([^"]+)(?<!:)//([^"]*)"|"./$1/$2"|g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|"\./([^"]+)(?<!:)//([^"]*)"|"./$1/$2"|g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|(?<!:)//[^},]+$||g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|/refs/heads/|/|g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|^(\s*)/\*|『|g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|\*/(\s*)$|』|g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|\n||g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|『[\s\S]*』||g'

KEYWORDS="bili|Bili|DJ|MV|pansou|push_agent|Youtube|YouTube|三盘|云盘|信息|兔小贝|公告|养生|初中|剧评|听书|哔哩|商店|声明|小品|小学|小说|少儿|幼儿|广告|广播|弹幕|急救|戏曲|扫码|推送|搜搜|搜索|教学|教育|本地|本机|版本|盘他|盘她|盘它|盘搜|直播|相声|看球|短剧|短视频|童趣|网盘|评书|课堂|配置|音乐|音频|预告|高中"

for i in 1 2 3 4 5 6; do
    if [ -f "dist/$i.json" ]; then
        jq --arg kw "$KEYWORDS" '
            if .sites then
                del(.sites[]? | select((.name // "" | test($kw)) or (.key // "" | test($kw))))
            else . end | del(.lives, .doh, .wallpaper, .notice, .logo)
        ' "dist/$i.json" >"fan/$i.json" || echo "Error processing $i.json"
    fi
done

find fan -name '[0-9].json' | xargs -r perl -pi -e 's/"name": "([^" ]*)\s*([^" ]*)\s*([^" ]*)\s*([^" ]*)\s*([^" ]*)"/"name": "$1$2$3$4$5"/g'

find fan -name '[0-9].json' | xargs -r perl -pi -e 's|(["=])https?:/([^"=]*)/raw\.([^/]+)/([^/]+)/([^/]+)/|$1https://gh-proxy.org/https://raw.githubusercontent.com/$4/$5/|g'
find fan -name '[0-9].json' | xargs -r perl -pi -e 's|(["=])https?:/([^"=]*)/github\.com/([^/]+)/([^/]+)/raw/|$1https://gh-proxy.org/https://raw.githubusercontent.com/$3/$4/|g'
find fan -name '[0-9].json' | xargs -r perl -pi -e 's|(["=])https?:/([^"=]+)\.jsdelivr\.net/gh/([^/]+)/([^/]+)@|$1https://gh-proxy.org/https://raw.githubusercontent.com/$3/$4/|g'

find fan -name '1.json' | xargs -r perl -pi -e 's|(["=])\./|$1https://gh-proxy.org/https://raw.githubusercontent.com/n3rddd/N3RD/master/JN/|g'
find fan -name '2.json' | xargs -r perl -pi -e 's|(["=])\./|$1https://gh-proxy.org/https://raw.githubusercontent.com/xyq254245/xyqonlinerule/main/|g'
find fan -name '3.json' | xargs -r perl -pi -e 's|(["=])\./|$1https://gh-proxy.org/https://raw.githubusercontent.com/yoursmile66/TVBox/main/|g'
find fan -name '4.json' | xargs -r perl -pi -e 's|(["=])\./|$1https://gh-proxy.org/https://raw.githubusercontent.com/ne7359/tvurl/main/|g'
find fan -name '5.json' | xargs -r perl -pi -e 's|(["=])\./|$1https://gh-proxy.org/https://raw.githubusercontent.com/ne7359/tvurl/main/xiaosa/|g'
find fan -name '6.json' | xargs -r perl -pi -e 's|(["=])\./|$1https://gh-proxy.org/https://raw.githubusercontent.com/wanganni/yinshiyuan/main/|g'
