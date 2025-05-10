#!/bin/sh

rm -rf fan/[0-9].json

curl -o- "https://raw.githubusercontent.com/n3rddd/N3RD/master/JN/lem.json" | sed 's/\r/\n/g' | grep -vE '^(\s*)(//|"notice"|"logo")' | grep -v "^$" >dist/1.json
curl -o- "https://raw.githubusercontent.com/xyq254245/xyqonlinerule/main/XYQTVBox.json" | sed 's/\r/\n/g' | grep -vE '^(\s*)(//|"notice"|"logo")' | grep -v "^$" >dist/2.json
curl -o- "https://raw.githubusercontent.com/yoursmile66/TVBox/main/XC.json" | sed 's/\r/\n/g' | grep -vE '^(\s*)(//|"notice"|"logo")' | grep -v "^$" >dist/3.json
curl -o- "https://raw.githubusercontent.com/ne7359/tvurl/main/0821.json" | sed 's/\r/\n/g' | grep -vE '^(\s*)(//|"notice"|"logo")' | grep -v "^$" >dist/4.json
curl -o- "https://raw.githubusercontent.com/ne7359/tvurl/main/xiaosa/api.json" | sed 's/\r/\n/g' | grep -vE '^(\s*)(//|"notice"|"logo")' | grep -v "^$" >dist/5.json
curl -o- "https://raw.githubusercontent.com/wanganni/yinshiyuan/main/tvbox18.json" | sed 's/\r/\n/g' | grep -vE '^(\s*)(//|"notice"|"logo")' | grep -v "^$" >dist/6.json
find dist -name '6.json' | xargs perl -pi -e "s/\'/\"/g"

find dist -name '[0-9].json' | xargs perl -pi -e 's|\t| |g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|"http([s]?)://([^"]+)(?<!:)\/\/([^"]*)"|"http$1://$2/$3"|g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|"http([s]?)://([^"]+)(?<!:)\/\/([^"]*)"|"http$1://$2/$3"|g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|(["=])(\.{2,3})/|$1./|g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|"\./([^"]+)(?<!:)\/\/([^"]*)"|"./$1/$2"|g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|"\./([^"]+)(?<!:)\/\/([^"]*)"|"./$1/$2"|g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|(?<!:)\/\/.*||g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|^(\s*)\/\*|「『|g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|\*\/(\s*)$|』」|g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|\n||g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|「『[\s\S]*』」||g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|"lives":(\s*)\[((?!\],).)+(\],)||g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|"doh":(\s*)\[((?!\],).)+(\],)||g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|\{[^\{]+公告((?!\},).)+(\},)||g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|\{[^\{]+应用商店((?!\},).)+(\},)||g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|\{[^\{]+本地视频((?!\},).)+(\},)||g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|\{[^\{]+本地｜视频((?!\},).)+(\},)||g'
find dist -name '[0-9].json' | xargs perl -pi -e 's|\{[^\{]+本机文件((?!\},).)+(\},)||g'

find dist -name '1.json' | xargs jq '.' >fan/1.json
find dist -name '2.json' | xargs jq '.' >fan/2.json
find dist -name '3.json' | xargs jq '.' >fan/3.json
find dist -name '4.json' | xargs jq '.' >fan/4.json
find dist -name '5.json' | xargs jq '.' >fan/5.json
find dist -name '6.json' | xargs jq '.' >fan/6.json

find fan -name '[0-9].json' | xargs perl -pi -e 's|/refs/heads/|/|g'
find fan -name '[0-9].json' | xargs perl -pi -e 's|(["=])https?:/([^"=]*)/raw\.([^/]+)/([^/]+)/|$1https://gh-proxy.com/https://raw.githubusercontent.com/$4/|g'
find fan -name '[0-9].json' | xargs perl -pi -e 's|(["=])https?:/([^"=]*)/github\.com/([^/]+)/([^/]+)/raw/|$1https://gh-proxy.com/https://raw.githubusercontent.com/$3/$4/|g'
find fan -name '[0-9].json' | xargs perl -pi -e 's|(["=])https?:/([^"=]+)\.jsdelivr\.net/gh/([^/]+)/([^/]+)@|$1https://gh-proxy.com/https://raw.githubusercontent.com/$3/$4/|g'

find fan -name '1.json' | xargs perl -pi -e 's|(["=])\./|$1https://gh-proxy.com/https://raw.githubusercontent.com/n3rddd/N3RD/master/JN/|g'
find fan -name '2.json' | xargs perl -pi -e 's|(["=])\./|$1https://gh-proxy.com/https://raw.githubusercontent.com/xyq254245/xyqonlinerule/main/|g'
find fan -name '3.json' | xargs perl -pi -e 's|(["=])\./|$1https://gh-proxy.com/https://raw.githubusercontent.com/yoursmile66/TVBox/main/|g'
find fan -name '4.json' | xargs perl -pi -e 's|(["=])\./|$1https://gh-proxy.com/https://raw.githubusercontent.com/ne7359/tvurl/main/|g'
find fan -name '5.json' | xargs perl -pi -e 's|(["=])\./|$1https://gh-proxy.com/https://raw.githubusercontent.com/ne7359/tvurl/main/xiaosa/|g'
find fan -name '6.json' | xargs perl -pi -e 's|(["=])\./|$1https://gh-proxy.com/https://raw.githubusercontent.com/wanganni/yinshiyuan/main/|g'

find fan -name '3.json' | xargs perl -pi -e 's|"https://([^/]+)/([^/]+)/([^/]+)/-/raw/|"https://gh-proxy.com/https://raw.githubusercontent.com/$2/$3/|g'
