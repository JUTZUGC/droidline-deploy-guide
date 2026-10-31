# Droidline 一键部署指南

> 第三方部署指南 · 非 Droidline 官方仓库。官方项目：[KnifeLemon/Droidline](https://github.com/KnifeLemon/Droidline)
> 内容来自官方文档（2026-10-31）。项目迭代快，请以[官方文档](https://droidline.dev/docs/install/)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 不开开发者选项、不插 USB、不 root：手机主动连电脑，同一句 touch 在五种接口里写法完全一样。

⚠️ 电脑端支持 Windows、macOS、Linux，手机端要 Android 9 及以上。首次尝试建议手机与电脑在同一 Wi-Fi；不在同一网络时要用隧道或自建中继。它只能用普通 App 能拿到的权限，所以系统级设置、部分受保护界面仍然碰不到。手机端 APK 从 GitHub Release 安装，需要允许未知来源。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/droidline-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按系统下载服务端、校验 SHA256 并解压，再引导你给手机装 agent、扫码完成配对，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## Droidline 是什么？

Droidline 是开源的电脑上起一个服务，手机装一个 App 扫码配对，之后用 Python、Node、命令行或 MCP 直接操作真机（协议：MIT，<img src="https://img.shields.io/github/stars/KnifeLemon/Droidline?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

把真机安卓操作抽象成一套命令：点击、输入、滑动、读取界面元素，同一份定义生成 Python、Node.js、CLI、HTTP 与 MCP 五种调用方式，适合自动化测试、批量跑机与交给 AI agent 操作。

- 三不依赖：不用 ADB、不插线、不需要 root
- 五种接口：Python、Node、CLI、HTTP、MCP 命令一致
- 手机主动连出：同 Wi-Fi 或经隧道都能用
- 端到端加密：每条指令加密传输
- 适合跑机架：多台手机同一套例程，各自网络独立
- 可交给 Agent：通过 MCP 让模型看屏幕并操作

（来源：[官方仓库](https://github.com/KnifeLemon/Droidline)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 4 | 2 |
| 不 | 用 |
| 五 | 种 |
| 手 | 机 |
| 自 | 带 |
| M | I |

| 需要注意 | 说明 |
|---|---|
| 只 | 能 |
| 手 | 机 |
| 跨 | 网 |
| 项 | 目 |
| 批 | 量 |

> 以上基于官方文档与社区反馈整理（2026-10-31），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
curl -fL -o droidline.tar.gz https://github.com/KnifeLemon/Droidline/releases/download/v0.1.12/droidline_0.1.12_linux_amd64.tar.gz
echo "2eeab8fa110a180a2e8b6f2a78138a98517e6bc171646c1d28501cfa76feafe9  droidline.tar.gz" | sha256sum -c -
tar -xzf droidline.tar.gz
echo "校验通过：把 droidline 放进 PATH 后启动，手机装 droidline-agent.apk 扫码配对"
```

安装包来源：[https://droidline.dev/docs/install/](https://droidline.dev/docs/install/)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认三平台服务端、Android 9+ 与扫码配对流程 | 已核对 2026-10-31 |
| Release v0.1.12 的 SHA256SUMS 已下载核对（Windows / Linux 服务端） | 已核对 2026-10-31 |
| 未实测配对与指令下发 | 说明 2026-10-31 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-10-31 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-31 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

Droidline 自带 MCP 能力，Release 里提供 `droidline.mcpb` 打包文件，可让 Claude、ChatGPT、Cursor 等直接操作手机；本仓库的 MCP 只提供部署步骤与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-31）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\droidline-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 发布包对照（v0.1.12）

| 用途 | 文件 | 大小 |
|---|---|---|
| Windows x64 服务端 | droidline_0.1.12_windows_amd64.zip | 9.9 MB |
| macOS Intel 服务端 | droidline_0.1.12_darwin_amd64.tar.gz | 9.9 MB |
| macOS Apple Silicon 服务端 | droidline_0.1.12_darwin_arm64.tar.gz | 9.1 MB |
| Linux x64 服务端 | droidline_0.1.12_linux_amd64.tar.gz | 9.7 MB |
| 手机端 Agent | droidline-agent.apk | 21.8 MB |
| MCP 打包文件 | droidline.mcpb | 15.0 MB |

Release 里带 `SHA256SUMS`，可一次核对全部文件。

## 三步跑通

1. **电脑端起服务**：解压后把 `droidline` 放进 PATH，直接运行，保持窗口开着
2. **手机装 agent**：安装 `droidline-agent.apk`，按提示打开必要权限
3. **扫码配对**：用手机扫电脑端显示的二维码，连接建立后即可发指令

## 支持的调用方式

- **Python / Node.js**：用官方客户端库发同一套命令
- **CLI**：终端里逐条发送，适合调试
- **HTTP**：直接打本机接口，任何语言都能接
- **MCP**：把 `droidline.mcpb` 装进支持 MCP 的客户端，让模型操作手机

## 它做不到的事

只用普通 App 权限，因此系统设置页、锁屏后的操作、部分受保护界面仍然无法控制；需要更高权限的自动化仍得走 ADB 或 root。

## 注意

- 手机需 Android 9 以上，首次配对要能扫码
- 不在同一网络时，需要自建中继或隧道
- 批量跑机建议给每台手机分配独立网络或代理
- 手机端来自 GitHub Release，安装前先核对 SHA256
- 端到端加密，但配对二维码不要发给不可信的人

## 常见坑

- 扫码无反应：确认电脑与手机在同一 Wi-Fi，且服务端窗口没有关闭
- 手机端闪退：检查 Android 版本与权限是否给全
- 指令超时：先看服务端日志，再确认手机没有被省电策略杀进程
- 找不到元素：界面刷新后再读一次，或改用文本定位
- 跨网络连不上：配置中继或隧道，别直接暴露本机端口
- Windows 拦执行：核对 SHA256 后再放行
- 多机互相干扰：给每台手机分配独立端口与网络

## 免责声明

本仓库为第三方指南，与 Droidline 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-31），项目迭代快，请以[官方文档](https://droidline.dev/docs/install/)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
