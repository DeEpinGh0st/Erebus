# Erebus CobaltStrike后渗透测试插件
### Auther by S0cke3t

# 更新日志 2019-10-05
* 重新组织代码结构,采用模块化设计
  >modules(插件各模块文件夹)  
  server(建议放到服务端运行的插件)

* 提权模块调整至Local Privilege Escalation选项卡
  >后续本地权限提升功能会添加到该菜单

# 更新日志 2019-09-30
* 添加自启动.
>支持Run,RunOnce,RunOnceEx

![AutoRun.png](https://i.loli.net/2019/09/30/db3f67MK8etyu9k.png)
* 整合IFEO菜单为Persistent
>后续持久化功能会添加到该菜单