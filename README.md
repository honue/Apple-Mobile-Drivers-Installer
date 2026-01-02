<h1 align="center">Apple Mobile Drivers Installer 🍎</h1>
<p align="center">Apple iPhone USB共享网络，识别已连接的 iPhone 设备</p>

<p align="center">
  <img src="https://github.com/NelloKudo/Apple-Mobile-Drivers-Installer/assets/98063377/36bb52c7-e395-4f02-a3d3-c589f980512b" alt="Your GIF" />
</p>
<p align="center">
<a herf="https://github.com/NelloKudo/Apple-Mobile-Drivers-Installer">Thanks for NelloKudo</a>  
</p>
<hr>

> 本分支修改内容：显示下载进度，使用最新的538.0.0.0 USB驱动，单独上传AppleMobileDeviceSupport64.msi 方便离线安装。

## 脚本安装
- 管理员运行 **PowerShell**（或 Windows Terminal 的 PowerShell）。
- 粘贴并回车：
  ```
  iex (Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/honue/Apple-Mobile-Drivers-Installer/main/AppleDrivInstaller.ps1')
  ```
- 等一分钟左右，驱动就装好了。

## 为什么需要它？驱动从哪下载？
- Windows 仍未自带苹果驱动，通常要手动装 iTunes/iCloud，步骤繁琐且慢。
- 本脚本直接从 **Microsoft Update Catalog** 拉取苹果 USB 驱动和网卡共享驱动，安装方式与 Windows Update 一致，只是更快。
- 仍需下载 iTunes 并用其中的 AppleMobileDeviceSupport64.msi，因为无法直接分发苹果的安装包。
- 管理员权限仅用于安装 .inf 驱动文件。

## 如何离线安装？
脚本本身需要联网；但你可以手动准备离线包：
1) 下载 **iTunes**：<https://www.apple.com/itunes/download/win64>
2) 安装 **AppleMobileDeviceSupport64.msi** (已上传至仓库，可直接下载)
3) 下载 CAB for x64：
   - Apple USB Drivers 538.0.0.0: <https://catalog.s.download.windowsupdate.com/d/msdownload/update/driver/drvs/2023/10/5fb262ea-d52d-46a7-9361-f3260ba57a1a_3e8075a4dded0a795131f82285e2f1a06525ebc2.cab>
   - Apple Tether USB Drivers 1.8.5.1: <https://catalog.s.download.windowsupdate.com/c/msdownload/update/driver/drvs/2017/11/netaapl_7503681835e08ce761c52858949731761e1fa5a1.cab>
4) 解压 .cab，右键 .inf 选择 **Install** 完成安装。