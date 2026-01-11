#!/bin/sh

# 目标地址与临时文件
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
    curl -s -L -k "$BASE_URL" -o "$GFW_BASE64"
elif command -v wget >/dev/null; then
    wget -q --no-check-certificate "$BASE_URL" -O "$GFW_BASE64"
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
grep -vE '^\!|\[|^@@|(https?://){0,1}[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' "$GFW_TEXT" |
    $SED_ERE 's#^(\|\|?)?(https?://)?##g' |
    $SED_ERE 's#/.*$|%2F.*$##g' |
    grep -E '([a-zA-Z0-9][-a-zA-Z0-9]*(\.[a-zA-Z0-9][-a-zA-Z0-9]*)+)' |
    $SED_ERE 's#^(([a-zA-Z0-9]*\*[-a-zA-Z0-9]*)?(\.))?([a-zA-Z0-9][-a-zA-Z0-9]*(\.[a-zA-Z0-9][-a-zA-Z0-9]*)+)(\*[a-zA-Z0-9]*)?$#\4#g' >"$TMP_DIR/domains.tmp"

# 4. 补充常用域名 (Google & Blogspot)
cat <<EOF >>"$TMP_DIR/domains.tmp"
blogspot.ae
blogspot.al
blogspot.am
blogspot.ba
blogspot.be
blogspot.bg
blogspot.ca
blogspot.cat
blogspot.ch
blogspot.cl
blogspot.co.uk
blogspot.com
blogspot.com.ar
blogspot.com.au
blogspot.com.br
blogspot.com.by
blogspot.com.co
blogspot.com.cy
blogspot.com.ee
blogspot.com.eg
blogspot.com.es
blogspot.com.mt
blogspot.com.ng
blogspot.com.tr
blogspot.com.uy
blogspot.cz
blogspot.de
blogspot.dk
blogspot.fi
blogspot.fr
blogspot.gr
blogspot.hk
blogspot.hr
blogspot.hu
blogspot.ie
blogspot.in
blogspot.is
blogspot.it
blogspot.jp
blogspot.kr
blogspot.li
blogspot.lt
blogspot.lu
blogspot.md
blogspot.mk
blogspot.mx
blogspot.my
blogspot.nl
blogspot.no
blogspot.pe
blogspot.pt
blogspot.qa
blogspot.ro
blogspot.ru
blogspot.se
blogspot.sg
blogspot.si
blogspot.sk
blogspot.sn
blogspot.tw
blogspot.ug
google.ac
google.ad
google.ae
google.af
google.ai
google.al
google.am
google.as
google.at
google.az
google.ba
google.be
google.bf
google.bg
google.bi
google.bj
google.bs
google.bt
google.by
google.ca
google.cat
google.cd
google.cf
google.cg
google.ch
google.ci
google.cl
google.cm
google.co.ao
google.co.bw
google.co.ck
google.co.cr
google.co.id
google.co.il
google.co.in
google.co.jp
google.co.ke
google.co.kr
google.co.ls
google.co.ma
google.co.mz
google.co.nz
google.co.th
google.co.tz
google.co.ug
google.co.uk
google.co.uz
google.co.ve
google.co.vi
google.co.za
google.co.zm
google.co.zw
google.com
google.com.af
google.com.ag
google.com.ai
google.com.ar
google.com.au
google.com.bd
google.com.bh
google.com.bn
google.com.bo
google.com.br
google.com.bz
google.com.co
google.com.cu
google.com.cy
google.com.do
google.com.ec
google.com.eg
google.com.et
google.com.fj
google.com.gh
google.com.gi
google.com.gt
google.com.hk
google.com.jm
google.com.kh
google.com.kw
google.com.lb
google.com.ly
google.com.mm
google.com.mt
google.com.mx
google.com.my
google.com.na
google.com.nf
google.com.ng
google.com.ni
google.com.np
google.com.om
google.com.pa
google.com.pe
google.com.pg
google.com.ph
google.com.pk
google.com.pr
google.com.py
google.com.qa
google.com.sa
google.com.sb
google.com.sg
google.com.sl
google.com.sv
google.com.tj
google.com.tr
google.com.tw
google.com.ua
google.com.uy
google.com.vc
google.com.vn
google.cv
google.cz
google.de
google.dj
google.dk
google.dm
google.dz
google.ee
google.es
google.eu
google.fi
google.fm
google.fr
google.ga
google.ge
google.gg
google.gl
google.gm
google.gp
google.gr
google.gy
google.hk
google.hn
google.hr
google.ht
google.hu
google.ie
google.im
google.iq
google.is
google.it
google.it.ao
google.je
google.jo
google.kg
google.ki
google.kz
google.la
google.li
google.lk
google.lt
google.lu
google.lv
google.md
google.me
google.mg
google.mk
google.ml
google.mn
google.ms
google.mu
google.mv
google.mw
google.mx
google.ne
google.nl
google.no
google.nr
google.nu
google.org
google.pl
google.pn
google.ps
google.pt
google.ro
google.rs
google.ru
google.rw
google.sc
google.se
google.sh
google.si
google.sk
google.sm
google.sn
google.so
google.sr
google.st
google.td
google.tg
google.tk
google.tl
google.tm
google.tn
google.to
google.tt
google.us
google.vg
google.vn
google.vu
google.ws
twimg.edgesuite.net
EOF

# 5. 去重并保存
sort -uf "$TMP_DIR/domains.tmp" >dist/gfw1.txt

echo "完成！纯域名列表已保存"
clean_up 0
