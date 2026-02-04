#!/bin/sh

BASE_URL='https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt'
TMP_DIR='dist/gfwlist'
GFW_BASE64="$TMP_DIR/gfw.b64"
GFW_TEXT="$TMP_DIR/gfw.txt"

# 自动识别系统 base64 解码参数
[ "$(uname -s)" = "Darwin" ] && B64_DECODE='base64 -D' || B64_DECODE='base64 -d'
# 自动识别 sed 扩展正则参数
[ "$(uname -s)" = "Darwin" ] || [ "$(uname -s)" = "FreeBSD" ] && SED_ERE='sed -E' || SED_ERE='sed -r'

clean_up() {
    rm -rf "$TMP_DIR"
    exit "$1"
}

mkdir -p "$TMP_DIR"

# 1. 下载 (支持 curl 或 wget)
echo "正在获取 GFWList..."
if command -v curl >/dev/null; then
    curl -fsSL --connect-timeout 10 --retry 3 "$BASE_URL" -o "$GFW_BASE64"
elif command -v wget >/dev/null; then
    wget -q --timeout=10 --tries=3 "$BASE_URL" -O "$GFW_BASE64"
else
    echo "错误: 未找到 curl 或 wget"
    clean_up 1
fi

# 2. 解码
$B64_DECODE "$GFW_BASE64" >"$GFW_TEXT" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "解码失败"
    clean_up 1
fi

# 3. 清洗域名逻辑 (核心过滤)
# 排除注释、白名单、IP地址
# 提取域名并去除通配符/路径
echo "正在提取域名..."
grep -vE '^\!|\[|^@@|([0-9]{1,3}\.){3}[0-9]{1,3}' "$GFW_TEXT" |
    $SED_ERE 's#^(\|\|?)?(https?://)?##g' |
    $SED_ERE 's#/.*$|%2F.*$##g' |
    grep -vE '\.[^\.]*\*[^\.]*$' |
    $SED_ERE 's#^(\.|\*\.)##g' >"$TMP_DIR/domains.tmp"

# 4. 补充常用域名 (Google & Blogspot)
cat <<EOF >>"$TMP_DIR/domains.tmp"
blogspot.com
google.com
twimg.edgesuite.net
EOF

curl -fsSL --connect-timeout 10 --retry 3 "https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/tld-not-cn.txt" | sed -r 's/^\.//' >>"$TMP_DIR/domains.tmp"

# 5. 去重并保存
cat "$TMP_DIR/domains.tmp" temp/gfw_wiki.txt temp/gfw_custom.txt | sed -r 's/[[:blank:]]//g' | sed -r 's/\r/\n/g' | grep -vE '^(\s*)$' | sort -uf >dist/gfw.txt

echo "完成！GFWList 域名列表已保存"
clean_up 0
