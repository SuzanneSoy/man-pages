#!/usr/bin/env zsh

: > index.html

for m in /usr/share/man/**/*(.); do
    target="${m#/usr/share/man/}";
    target="${target%.gz}";
    printf %s\\n "$target";
    printf %s\\n "$target" | sed -e 's/&/&amp;/g' | sed -e "s/'/\&quot;/g" | sed -e 's/</\&lt;/g' | sed -e 's/>/\&gt;/g' | sed -e 's~.*~<a href="&">&</a><br />~' >> index.html
    mkdir -p "$(dirname "$target")";
    man2html "$m" | sed -ne '/^$/,$p' | perl -pe 'BEGIN{$k=0};s/<DT>/"<DT id=\"" . ++$k . "\">"/e' > "$target.html";
done

