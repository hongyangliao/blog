---
title: gitclone非22端口clone项目
date: 2017-11-21 16:34:56
tags:
    - Git
categories: Git
---

#### 使用git clone命令clone项目时，如果repository的SSH端口不是标准22端口时（例如，SSH tunnel模式，等等），可以使用如下命令：

```
git clone ssh://git@hostname:port/.../xxx.git
```
