# GTNH 2.9.0-beta-1 私人服务器部署资料

三人家用服务器（正版账号 + Radmin VPN 虚拟局域网联机）的部署配置与说明文档存档。

## 内容说明

| 文件 | 说明 |
|---|---|
| `部署说明.md` | 服务器启动/停止/配置/备份说明 |
| `联机指南.md` | 给玩家的 Radmin VPN 联机步骤 |
| `客户端分发说明.md` | 客户端打包分发方案（三人版本必须一致） |
| `server/start.bat` | 一键启动脚本（Java 17，固定 6GB 内存） |
| `server/server.properties` | 服务器配置（正版验证、25565 端口、RWG 地形） |
| `server/java9args.txt` | RFB 启动参数（Java 17+ 兼容） |

> 本仓库**不含**服务器本体（mods / 世界存档 / 日志），不构成完整可运行的服务器文件，仅作配置与经验存档。

## 服务器结构要点（如何重建）

- 版本：GTNH **2.9.0-beta-1**（基于 Minecraft 1.7.10），官方未发布该版本的服务端包
- 服务端 = 官方 2.8.4 的启动结构（`lwjgl3ify-forgePatches.jar` 引导 + RetroFuturaBootstrap）+ 2.9.0-beta-1 的 mods/config（取自本机 Prism Launcher 完整客户端实例）
- 启动命令（官方同款结构）：

  ```
  java -Xms6G -Xmx6G -Dfml.readTimeout=180 @java9args.txt -jar lwjgl3ify-forgePatches.jar nogui
  ```

- 运行环境：JDK 17（GTNH 支持 Java 17–25）

## 服务端可用化的 mod 调整

纯客户端整合包直接跑服务端会崩，需移除两类 mod（见各崩溃场景）：

1. **服务端加载即崩的**：
   - `txloader`（提前加载 StringTranslate，导致 gregtech 早期 mixin 失败）
   - `coretweaks 0.3.4.6`（其类转换缓存导致 MinecraftServer.main 丢失；beta-1 版本 bug）
   - `NotEnoughCharacter`（拼音搜索）、`defaultworldgenerator`（加载客户端 GUI 类）
2. **客户端专用但未标记 clientSideOnly、会引发连接被拒的**：
   - `freecam`（已放回服务端解决；服务端加载无害）

完整移除清单共 20 个，见部署说明。

## 踩坑记录（供参考）

- 2.9.0-beta-1 无官方服务端包；GitHub 上该版本的 zip 只是 config 源包（无 mod jar）
- 官方 2.8.4 服务端包（441MB）的结构与启动脚本是权威参照，可用 HTTP Range 请求只抠取所需小文件
- beta-1 客户端自带的 `lwjgl3ify-forgePatches.jar`（3.0.23）Manifest Main-Class 即服务端入口 `ServerMain`，可直接用作服务端引导 jar
- 首个纯客户端 mod 列表与官方 2.8.4 服务端包 mod 列表的差异对比，是识别"该删谁"的高效线索

## 备份提醒

GTNH 世界后期体积大，请定期备份 `world/` 文件夹（部署说明中有详细建议）。
