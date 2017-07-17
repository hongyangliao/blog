---
title: OpenCV配置
date: 2017-07-17 9:30:00
tags: 
    - OpenCV
categories: C++
---

**OpenCV配置**

#### 1.计算机->（右键）属性->高级系统设置->高级（标签）->环境变量->系统变量里添加变量Path值添加地址(默认是32位的情况，如果64位请看备注)
```
      D:\opencv2.4.10\opencv\build\x86\vc10\bin
```

#### 2.项目（菜单项）->…属性->VC++目录：需要配置“可执行文件目录”,“包含目录”和“库目录”三项。

```
可执行文件目录
D:\opencv 2.4.10\opencv\build\x86\vc10\bin
包含目录
D:\opencv 2.4.10\opencv\build\include\opencv

D:\opencv 2.4.10\opencv\build\include\opencv2

D:\opencv 2.4.10\opencv\build\include
```

#### 3.配置连接器：项目（菜单项）->…属性->连接器->输入->附加依赖项
```
opencv_ml2410d.lib
opencv_calib3d2410d.lib
opencv_contrib2410d.lib
opencv_core2410d.lib
opencv_features2d2410d.lib
opencv_flann2410d.lib
opencv_gpu2410d.lib
opencv_highgui2410d.lib
opencv_imgproc2410d.lib
opencv_legacy2410d.lib
opencv_objdetect2410d.lib
opencv_ts2410d.lib
opencv_video2410d.lib
opencv_nonfree2410d.lib
opencv_ocl2410d.lib
opencv_photo2410d.lib
opencv_stitching2410d.lib
opencv_superres2410d.lib
opencv_videostab2410d.lib
```

#### 4.复制dll 文件到C盘system32文件夹下，
```
dll文件在D:\opencv 2.4.10\opencv\build\x86\vc10\bin
```

#### 5.打开vs工程，在.cpp前添加：
```
#include "opencv2/opencv.hpp"
#include <opencv2/highgui/highgui.hpp>
#include "opencv2/nonfree/nonfree.hpp"
#include "opencv2/legacy/legacy.hpp"

using namespace cv;
using namespace std;
```

#### 备注
    如果出现x64与目标计算机不匹配这类的话。打开链接器里面的高级，其默认是x86,将目标计算机改为x64,然后再点此时这个界面上的配置管理器，将活动解决方案平台改为x64，最后依照上面的1,2,3,4,步骤重来一次配置，注意选为x64。
