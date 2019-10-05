# Erebus CobaltStrike后渗透测试插件
### Auther by S0cke3t
│  Main.cna (插件入口文件)
│
├─exp (exp文件目录)
│  └─8120 (EXP的CVE后缀编号)
│
├─modules (插件模块目录)
│ 
│
├─script (需要加载的powershell等第三方脚本)
│
│
└─server(建议放到服务端运行的插件)
# 更新日志 2019-10-05
* 重新组织代码结构,采用模块化设计
* 提权模块调整至Local Privilege Escalation选项卡
# 更新日志 2019-09-30
* 添加自启动.
>支持Run,RunOnce,RunOnceEx

![AutoRun.png](https://i.loli.net/2019/09/30/db3f67MK8etyu9k.png)
* 整合IFEO菜单为Persistent
>后续持久化功能会添加到该菜单