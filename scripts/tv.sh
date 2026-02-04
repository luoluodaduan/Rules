#!/bin/sh

urls="https://raw.githubusercontent.com/n3rddd/N3RD/master/JN/lem.json
https://raw.githubusercontent.com/xyq254245/xyqonlinerule/main/XYQTVBox.json
https://raw.githubusercontent.com/yoursmile66/TVBox/main/XC.json
https://raw.githubusercontent.com/ne7359/tvurl/main/0821.json
https://raw.githubusercontent.com/ne7359/tvurl/main/xiaosa/api.json
https://raw.githubusercontent.com/wanganni/yinshiyuan/main/tvbox18.json"
KEYWORDS='bili|Bili|csp_Pan|DJ|MV|pansou|push_agent|Youtube|YouTube|三盘|云盘|代理|信息|兔小贝|公告|养生|初中|剧评|听书|哔哩|商店|声明|外网|宣传片|小品|小学|小说|少儿|幼儿|广告|广播|弹幕|急救|戏曲|扫码|推送|搜搜|搜索|教学|教育|本地|本机|版本|盘Ta|盘他|盘她|盘它|盘搜|直播|相声|看球|短剧|童趣|网盘|翻墙|评书|课堂|配置|音乐|音频|预告|高中'
export PROXY_URL="https://gh-proxy.org"

rm -rf fan/[0-9].json

i=1
for url in $urls; do
    output="dist/$i.json"
    curl -fsSL --connect-timeout 10 --retry 3 "$url" | sed -r 's/\r/\n/g' | grep -vE '^(\s*)//|^(\s*)$' >"$output"
    i=$((i + 1))
done

find dist -name '[0-9].json' | xargs -r perl -pi -e 's|\t| |g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|　| |g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|/refs/heads/|/|g'
find dist -name '[0-9].json' -exec sh -c 'json5 "$1" >"$1.tmp" && mv "$1.tmp" "$1"' _ {} \;
find dist -name '[0-9].json' | xargs -r perl -pi -e 's{https?:\K/+([^/]+)}{//$1}g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's{"\.\K/{2,}([^/]+)}{/$1}g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's{(https?://|"\./)[^:,"]+\K/{2,}}{/}g'
find dist -name '[0-9].json' | xargs -r perl -pi -e 's|"name" *: *"([^" ]*) *([^" ]*) *([^" ]*) *([^" ]*) *([^" ]*) *([^" ]*)"|"name": "$1$2$3$4$5$6"|g'

for i in 1 2 3 4 5 6; do
    input="dist/$i.json"
    output="fan/$i.json"
    if [ -f "$input" ]; then
        jq --arg kw "$KEYWORDS" '
            if .sites then
                del(.sites[]? | select(((.name // "") | test($kw; "")) or ((.key // "") | test($kw; "")) or ((.api // "") | test($kw; ""))))
            else . end
            |
            if .lives then
                del(.lives[]? | select(((.name // "") | test($kw; ""))))
            else . end
            |
            del(.wallpaper, .notice, .logo, .doh)
        ' "$input" >"$output"
    else
        echo "跳过：未找到 $input"
    fi
done

find fan -name '[0-9].json' | xargs -r perl -pi -e 's|(["=])https?:/([^"=]*)/raw\.([^/"]+)/([^/"]+)/([^/"]+)/|$1$ENV{PROXY_URL}/https://raw.githubusercontent.com/$4/$5/|g'
find fan -name '[0-9].json' | xargs -r perl -pi -e 's|(["=])https?:/([^"=]*)/github\.com/([^/"]+)/([^/"]+)/raw/|$1$ENV{PROXY_URL}/https://raw.githubusercontent.com/$3/$4/|g'
find fan -name '[0-9].json' | xargs -r perl -pi -e 's|(["=])https?:/([^"=]+)\.jsdelivr\.net/gh/([^/"]+)/([^/"]+)@|$1$ENV{PROXY_URL}/https://raw.githubusercontent.com/$3/$4/|g'

find fan -name '1.json' | xargs -r perl -pi -e 's|"\./|"$ENV{PROXY_URL}/https://raw.githubusercontent.com/n3rddd/N3RD/master/JN/|g'
find fan -name '2.json' | xargs -r perl -pi -e 's|"\./|"$ENV{PROXY_URL}/https://raw.githubusercontent.com/xyq254245/xyqonlinerule/main/|g'
find fan -name '3.json' | xargs -r perl -pi -e 's|"\./|"$ENV{PROXY_URL}/https://raw.githubusercontent.com/yoursmile66/TVBox/main/|g'
find fan -name '4.json' | xargs -r perl -pi -e 's|"\./|"$ENV{PROXY_URL}/https://raw.githubusercontent.com/ne7359/tvurl/main/|g'
find fan -name '5.json' | xargs -r perl -pi -e 's|"\./|"$ENV{PROXY_URL}/https://raw.githubusercontent.com/ne7359/tvurl/main/xiaosa/|g'
find fan -name '6.json' | xargs -r perl -pi -e 's|"\./|"$ENV{PROXY_URL}/https://raw.githubusercontent.com/wanganni/yinshiyuan/main/|g'
