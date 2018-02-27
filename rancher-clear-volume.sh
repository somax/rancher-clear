#!/bin/bash

# 获取所有 inactive 状态的 volume 并逐行读取...
rancher volume -a --format '{{.ID}} {{.Volume.State}}' |egrep 'detached|inactive' | while read l;
do

    # ...删除
    echo "$l" | awk '{print $1}' | xargs rancher rm

    # 循环期间如果按了 Ctrl + C 则退出
    test $? -gt 128 && break;

done
