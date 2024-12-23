import { Pref } from "../../Index"
import { MyApp, Daily, Gray, Online } from "../main/ets/base/MyApp"
import { LogX } from "../main/ets/utils/log"
import { scanCore, scanBarcode } from '@kit.ScanKit';
// 导入默认界面需要的日志模块和错误码模块
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from "@kit.ArkUI";


@Component
export struct DebugKitView {
  envs: string[] = [Daily, Gray, Online]
  currentEnv: string = MyApp.getInstance().getEnv()
  @State urlHistory: string[] = []
  urlInputText: string = ''
  pref?: Pref
  static store_name = "debugKit_store"
  static key_url_history = "key_url_history"

  aboutToAppear(): void {
    LogX.d("mmm", 'aboutToAppear')
    this.pref = Pref.createSync(DebugKitView.store_name)
    this.urlHistory = this.pref?.getValueSync<string[]>(DebugKitView.key_url_history) ?? []
  }

  aboutToDisappear(): void {
    LogX.d("mmm", 'aboutToDisappear')
  }

  isCurrent(env: string): boolean {
    return env === this.currentEnv
  }

  build() {
    Column() {
      this.switchEnv()
      Divider().height(1).backgroundColor(Color.Gray).margin({ top: 10 })
      this.h5Load()

    }.alignItems(HorizontalAlign.Start).padding(12)
  }

  @Builder
  switchEnv() {
    Row() {
      Text(`环境:`)
      ForEach(this.envs, (env: string) => {
        Row() {
          Radio({ value: env, group: 'radioGroup' }).checked(this.isCurrent(env))
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                LogX.d("mmm", "onChange", env, ", current", this.currentEnv)
                if (env !== this.currentEnv) {
                  MyApp.getInstance().switchEnv(env)
                }
              }

            })
          Text(env)
        }.margin({ right: 20 })
      }, (item: string) => item)
    }.margin({ top: 10 })
  }

  @Builder
  h5Load() {
    Column() {
      Row() {
        Text('H5任意门').height(50)
      }.margin({ top: 10 })

      Row() {
        TextInput({ placeholder: '输入网址' }).layoutWeight(1)
          .enterKeyType(EnterKeyType.Go)
          .onChange((text) => {
            this.urlInputText = text
          })
          .onSubmit((enterKey, event) => {
            LogX.d('mmm', '输入法回车键的类型值', enterKey, event.text)
            this.handleUrl(this.urlInputText)
          })
        Button('跳转').onClick((event) => {
          this.handleUrl(this.urlInputText)
        })
      }

      Button('扫一扫').onClick((event) => {
        this.scan()
      }).margin(12).width('100%').alignSelf(ItemAlign.Center)
      // Text('历史记录')
    }.width('100%').alignItems(HorizontalAlign.Start)

    ForEach(this.urlHistory, (url: string) => {
      Row() {
        Text(url).height(20).maxLines(1).ellipsisMode(EllipsisMode.END)
        Button("Go").backgroundColor(Color.Grey).onClick(()=>{
          this.handleUrl(url)
        })
      }.width('100%').padding({left:10,right:10,top:10}).justifyContent(FlexAlign.SpaceBetween)

    }, (item: string) => item)

  }

  scan() {
    if (canIUse('SystemCapability.Multimedia.Scan.ScanBarcode') === false
      || canIUse('SystemCapability.Multimedia.Scan.Core') === false) {
      promptAction.showToast({
        message: "不支持扫码"
      })
      return
    }
    // 定义扫码参数options
    let options: scanBarcode.ScanOptions = {
      scanTypes: [scanCore.ScanType.ALL],
      enableMultiMode: true,
      enableAlbum: true
    };
    try {
      // 可调用getContext接口获取当前页面关联的UIAbilityContext
      scanBarcode.startScanForResult(getContext(this), options).then((result: scanBarcode.ScanResult) => {
        // 解析码值结果跳转应用服务页
        if (result.originalValue) {
          this.handleUrl(result.originalValue)
        }
        LogX.d('mmm',
          `Succeeded in getting ScanResult by promise with options, result is ${JSON.stringify(result)}`);
      }).catch((error: BusinessError) => {
        LogX.d('mmm',
          `Failed to get ScanResult by promise with options. Code:${error.code}, message: ${error.message}`);
      });
    } catch (error) {
      LogX.d('mmm',
        `Failed to start the scanning service. Code:${error.code}, message: ${error.message}`);
    }
  }

  handleUrl(url: string) {
    this.addHistory(url)
    this.goRoute(url)
  }

  goRoute(url: string) {
    LogX.d("mmm", 'go route', url)
  }

  addHistory(url: string) {
    const index = this.urlHistory.indexOf(url)
    let changed = false
    if (index > 0) {
      this.urlHistory.splice(index, 1)
      changed = true
    }
    if (this.urlHistory[0] !== url) {
      this.urlHistory = [url, ...this.urlHistory]
      changed = true
    }
    if (changed) {
      this.pref?.setValueSync(DebugKitView.key_url_history, this.urlHistory)
    }
  }
}
