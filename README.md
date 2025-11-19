# flutter_sim_check

一个用于检测 SIM 卡状态和运营商信息的 Flutter 插件，支持 Android 和 iOS。

## 功能

- ✅ 检测设备是否插入 SIM 卡
- ✅ 获取运营商名称
- ✅ 获取 MCC (Mobile Country Code) 
- ✅ 获取 MNC (Mobile Network Code)
- ✅ 支持 Android 和 iOS 平台

## 安装

在 `pubspec.yaml` 文件中添加依赖：

```yaml
  flutter_sim_check:
    git:
      url: https://github.com/yanmingLiu/sim_check
```

然后运行：

```bash
flutter pub get
```

## 权限配置

### Android

在 `android/app/src/main/AndroidManifest.xml` 中添加权限：

```xml
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
```




## 使用方法

### 导入包

```dart
import 'package:flutter_sim_check/flutter_sim_check.dart';
```

### 基本用法

#### 1. 检测 SIM 卡状态

```dart
bool hasSim = await FlutterSimCheck.hasSimCard();
print('设备是否插入 SIM 卡: $hasSim');
```

#### 2. 获取完整 SIM 信息

```dart
SimInfo simInfo = await FlutterSimCheck.getSimInfo();
print('SIM 卡状态: ${simInfo.hasSimCard}');
print('运营商名称: ${simInfo.carrierName ?? "未知"}');
print('MCC: ${simInfo.mcc ?? "未知"}');
print('MNC: ${simInfo.mnc ?? "未知"}');
```

## 完整示例

```dart
import 'package:flutter/material.dart';
import 'package:flutter_sim_check/flutter_sim_check.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIM Check Demo',
      home: SimCheckPage(),
    );
  }
}

class SimCheckPage extends StatefulWidget {
  @override
  _SimCheckPageState createState() => _SimCheckPageState();
}

class _SimCheckPageState extends State<SimCheckPage> {
  String _simStatus = '检测中...';

  @override
  void initState() {
    super.initState();
    _checkSimStatus();
  }

  Future<void> _checkSimStatus() async {
    try {
      final simInfo = await FlutterSimCheck.getSimInfo();
      setState(() {
        _simStatus = '''
SIM 卡状态: ${simInfo.hasSimCard ? '已插入' : '未插入'}
运营商: ${simInfo.carrierName ?? '未知'}
MCC: ${simInfo.mcc ?? '未知'}
MNC: ${simInfo.mnc ?? '未知'}
        ''';
      });
    } catch (e) {
      setState(() {
        _simStatus = '检测失败: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIM 卡检测'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _simStatus,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkSimStatus,
              child: Text('重新检测'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## API 文档

### FlutterSimCheck

#### 方法

##### `getSimInfo()`

获取完整的 SIM 卡信息。

**返回值:** `Future<SimInfo>`

##### `hasSimCard()`

检测设备是否插入 SIM 卡。

**返回值:** `Future<bool>`

### SimInfo

SIM 卡信息数据类。

#### 属性

| 属性 | 类型 | 描述 |
|------|------|------|
| `hasSimCard` | `bool` | 是否插入 SIM 卡 |
| `carrierName` | `String?` | 运营商名称 |
| `mcc` | `String?` | 移动国家码 |
| `mnc` | `String?` | 移动网络码 |

## 平台支持

| 平台 | 支持状态 |
|------|----------|
| Android | ✅ |
| iOS | ✅ |
| Web | ❌ |
| Windows | ❌ |
| macOS | ❌ |
| Linux | ❌ |

## 运行示例

```bash
cd example
flutter run
```

## 注意事项

1. **权限要求**: 在 Android 上需要 `READ_PHONE_STATE` 权限
2. **iOS 限制**: 部分信息在 iOS 模拟器上可能无法正确获取
3. **网络状态**: 某些信息需要在有网络连接时才能获取
4. **设备差异**: 不同设备厂商可能返回不同格式的数据

## 许可证

MIT License
