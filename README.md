# Erebus CobaltStrike后渗透测试插件  
### Auther by S0cke3t  
**部分功能只适用于cobalt strike 4.x**  
**由于异步处理问题，某些功能可能会存在BUG**  
**暂时未找到解决方法，如果大佬们有解决方案，欢迎联系我~**  

##  更新日志 2020-06-09(V1.3.3)
- 信息收集模块，添加 
  - cmd,powershell命令执行历史  
  - 最近使用文件历史  
- post模块，添加  
  > 进程迁移功能  
  根据用户配置，将原生会话文件位置迁移到新的目录，并重新命名文件名称生成新会话  
  ![](README_md_files/image.png?v=1&type=image)   
  Migrate directory: 进行迁移的目录，此项在setting.txt文件中进行配置。  
  Process name: 新进程名，自动生成，生成规则可在common.sl中修改。  
  Keep old connection: 是否保持原有会话连接。  
  **注: 迁移只支持原生会话，且只能迁移一次 !**    
  详见: Post----Migrate  
- 其他  
  - 调整备注信息，Ver--->NT  
  - 隐藏部份功能执行时的细节信息  
  - 调整代码  
 
##	更新日志 2020-05-06 (V1.3.2)

 - LPE整合，添加
	> 整合三款Potato提权  
	Rotten-Potato  
	Juicy-Potato  
	Sweet-Potato  
	详见:Local Privilege Escalation-----Potatos
 - post模块添加窃取windows凭证功能
	>基于bmimikatz
 - 调整上线备注信息
   >删除arch信息
 - 附
	>免杀的mimikatz 2.2.0 x64  
	可过360，腾讯管家，金山，火绒动静检测，其余未测试。  
	详见: post/SoftMgr.exe  
##	更新日志 2020-04-14 (V1.3.1)  
* 信息收集模块功能添加  
	> 信息收集模块添加`审计主机可用提权漏洞功能`,此功能基于`windows-exploit-suggester`,执行此功能后会在插件logs目录下生成对应`主机名-audit.txt`的审计文件  
	详见: gather----Audit available lpe vulnerability  
	**注意: 由于此功能涉及到的交互操作较多以及异步处理问题，在网络状况欠佳时，可能会导致等待时间较长。请慎用此功能！**  
* 提权模块EXP添加  
	>提权模块添加`MS16-075`  

##  更新日志 2020-04-09  (V1.3.0)  
* 完善信息收集模块  
	> 详见gather----Collector  
	**注意: 重定向文件必须与脚本中定义的文件名一致**  
	
	![20200409220109.png](README_md_files/20200409220109.png?v=1&type=image)  
*  添加post模块`enable rdp`,`turn off firewall`功能对windows 2003 (<=NT 5.2)的支持  
* 改善模块加载顺序  提升使用体验  
* 精简代码  
## 更新日志 2020-03-08  
* 添加`cookie steal`  
  >支持`搜狗,360,360极速,QQ,火狐,谷歌,2345`  
	  更多使用事项请移步[Browser-cookie-steal](https://github.com/DeEpinGh0st/Browser-cookie-steal)  
  详见:post----Steal-cookie  
  
  ![20200308200339.png](https://i.loli.net/2020/03/08/bzrnHtWvc1VxENu.png)

## 更新日志 2019-12-30
* 添加`SafetyKatz`
  >此功能为一个修改的`mimikatz`,截至目前(2019-12-30)此方式可绕过大部分AV检测和运行  
  详见:Interact----SafetyKatz 命令  
* 添加`Seatbelt`
  >此功能是一个信息收集模块,可实现对目标系统,用户等其他信息的收集整理, 用户可指定收集的条目  
  详见:Interact----Seatbelt 命令  
  Usage  
  Seatbelt 帮助信息    
  Seatbelt system 收集系统信息  
  Seatbelt user 收集用户信息  
  Seatbelt xxx yyy  指定收集条目  

## 更新日志 2019-12-18
* 添加`EventLogMaster`第三方工具的RDP痕迹清除模块
  >详见: Third-party----EventLogMaster  

* Screenshot  
  
  ![20191218134832.png](https://i.loli.net/2019/12/18/AN7Q438RLyUVdts.png)  

  >清除登陆者为172.16.12.5的RDP记录  
    关于`Logon type`请参考[Windows Logon Type的含义](https://blog.csdn.net/flyhaze/article/details/5703931)  

  ![20191218142234.png](https://i.loli.net/2019/12/18/jfF8mCSpih4kxvq.png)
  ![20191218135225.png](https://i.loli.net/2019/12/18/rfBLJcRyevl827G.png)

## 更新日志 2019-12-09
* 修复BUG
* 添加powershell访问限制下执行powershell功能
  >详见: Post---Sharpshell  
  Note: 此功能需要目标支持 `.Net Framework 2.0`

  ![sharpshell.png](https://i.loli.net/2019/12/09/9xFOLltAwIS5kKo.png)

## 更新日志 2019-11-22
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

## 更新日志 2019-11-4
* 添加MS16-032提权模块
    >利用后需要手动清理残留文件

  ![20191104172829.png](https://i.loli.net/2019/11/04/9vNRyPJoA578QHg.png)

## 更新日志 2019-10-13
* 添加关于菜单
  >用户手册(更新中)  
  检查更新

* Juicy Potato  Payload文件采用随机名称

* 清理本地残留文件

## 更新日志 2019-10-06
* 持久化
  >自启动添加Winlogon,Logon Scripts支持  
   添加服务注册

  ![20191006205222.png](https://i.loli.net/2019/10/06/QfS4qXragDejNTl.png)
## 更新日志 2019-10-05
* 重新组织代码结构,采用模块化设计
  >modules(插件各模块文件夹)  
  server(建议放到服务端运行的插件)

* 提权模块调整至Local Privilege Escalation选项卡
  >后续本地权限提升功能会添加到该菜单

* 新增Juicy Potato本地提权模块

  ![20191005232005.png](https://i.loli.net/2019/10/05/HNiacQ3RfAO1XWy.png)

## 更新日志 2019-09-30
* 添加自启动.
  >支持Run,RunOnce,RunOnceEx

   ![AutoRun.png](https://i.loli.net/2019/09/30/db3f67MK8etyu9k.png)
* 整合IFEO菜单为Persistent
  >后续持久化功能会添加到该菜单

## 参考文献
[Windows中常见后门持久化方法总结](http://1t.click/a4rQ)  
[RdpThief ](https://github.com/0x09AL/RdpThief)  
[RdpThief 原理](https://www.mdsec.co.uk/2019/11/rdpthief-extracting-clear-text-credentials-from-remote-desktop-clients/)  
[提权: 武器化CVE-2019-1405/CVE-2019-1322](https://github.com/apt69/COMahawk)  
[如何绕过PowerShell访问限制并实现PowerShell代码执行 ](https://www.freebuf.com/articles/system/218883.html)  
[EventLogMaster-RDP日志取证&清除](https://github.com/QAX-A-Team/EventLogMaster)  
[SweetPotato_CS](https://github.com/Tycx2ry/SweetPotato_CS)  
[xencrypt](https://github.com/the-xentropy/xencrypt)
