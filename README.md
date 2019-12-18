# Erebus CobaltStrike后渗透测试插件
### Auther by S0cke3t


# 更新日志 2019-12-18
* 添加`EventLogMaster`第三方工具的RDP痕迹清除模块
  >详见: Third-party----EventLogMaster  

* Screenshot  
  
  ![20191218134832.png](https://i.loli.net/2019/12/18/AN7Q438RLyUVdts.png)  

  >清除登陆者为172.16.12.5的RDP记录  
    关于`Logon type`请参考[Windows Logon Type的含义](https://blog.csdn.net/flyhaze/article/details/5703931)  

  ![20191218142234.png](https://i.loli.net/2019/12/18/jfF8mCSpih4kxvq.png)
  ![20191218135225.png](https://i.loli.net/2019/12/18/rfBLJcRyevl827G.png)

# 更新日志 2019-12-09
* 修复BUG
* 添加powershell访问限制下执行powershell功能
  >详见: Post---Sharpshell  
  Note: 此功能需要目标支持 `.Net Framework 2.0`

  ![sharpshell.png](https://i.loli.net/2019/12/09/9xFOLltAwIS5kKo.png)

# 更新日志 2019-11-22
* 添加`RdpThief`第三方模块【详见Third-party菜单】
    >此模块可从目标RDP客户端中提取明文账户密码  
    Note: 需要目标支持`Visual C++ 2015 Redistributable` 或更高版本支持  
    rdpthief-enable ----- 注入mstsc  
    rdpthief-disable ----- 停止  
    rdpthief-dump ----- 获取明文信息

  ![20191121172553.png](https://i.loli.net/2019/11/21/rOu4IM39GAXcKaW.png)

* 添加 CVE-2019-1322 & CVE-2019-1405   COM本地提权模块
  >Note: 使用此模块时sleep时间不宜过短

  ![20191122141456.png](https://i.loli.net/2019/11/22/7fmspHtorcJWKMn.png)

# 更新日志 2019-11-4
* 添加MS16-032提权模块
    >利用后需要手动清理残留文件

  ![20191104172829.png](https://i.loli.net/2019/11/04/9vNRyPJoA578QHg.png)

# 更新日志 2019-10-13
* 添加关于菜单
  >用户手册(更新中)  
  检查更新

* Juicy Potato  Payload文件采用随机名称

* 清理本地残留文件

# 更新日志 2019-10-06
* 持久化
  >自启动添加Winlogon,Logon Scripts支持  
   添加服务注册

  ![20191006205222.png](https://i.loli.net/2019/10/06/QfS4qXragDejNTl.png)
# 更新日志 2019-10-05
* 重新组织代码结构,采用模块化设计
  >modules(插件各模块文件夹)  
  server(建议放到服务端运行的插件)

* 提权模块调整至Local Privilege Escalation选项卡
  >后续本地权限提升功能会添加到该菜单

* 新增Juicy Potato本地提权模块

  ![20191005232005.png](https://i.loli.net/2019/10/05/HNiacQ3RfAO1XWy.png)

# 更新日志 2019-09-30
* 添加自启动.
  >支持Run,RunOnce,RunOnceEx

   ![AutoRun.png](https://i.loli.net/2019/09/30/db3f67MK8etyu9k.png)
* 整合IFEO菜单为Persistent
  >后续持久化功能会添加到该菜单

## 参考文献
[Windows中常见后门持久化方法总结](http://1t.click/a4rQ)  
[RdpThief Github传送门](https://github.com/0x09AL/RdpThief)  
[RdpThief 原理](https://www.mdsec.co.uk/2019/11/rdpthief-extracting-clear-text-credentials-from-remote-desktop-clients/)  
[提权: 武器化CVE-2019-1405/CVE-2019-1322](https://github.com/apt69/COMahawk)  
[如何绕过PowerShell访问限制并实现PowerShell代码执行 ](https://www.freebuf.com/articles/system/218883.html)  
[EventLogMaster-RDP日志取证&清除](https://github.com/QAX-A-Team/EventLogMaster)