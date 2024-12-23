import { AbilityConstant, appRecovery, ConfigurationConstant, UIAbility, Want, errorManager,AbilityStage } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { debugKit, LogX, MyApp } from '@ohos/common';
import BuildProfile from 'BuildProfile';
import { BusinessError } from '@kit.BasicServicesKit';



export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    let appContext = this.context.getApplicationContext()
    appContext.setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);

    LogX.d('mmm', 'Ability onCreate', 11, debugKit.getName(), JSON.stringify({
      "code": 0, "message": "打印一个json字符串", "data": ""
    }))

    // appRecovery.enableAppRecovery(
    //   appRecovery.RestartFlag.ALWAYS_RESTART,
    //   appRecovery.SaveOccasionFlag.SAVE_WHEN_ERROR,
    //   appRecovery.SaveModeFlag.SAVE_WITH_FILE
    // );
    //
    // appRecovery.setRestartWant({
    //   bundleName: BuildProfile.BUNDLE_NAME,
    //   abilityName: 'EntryAbility'
    // })

  }


  onDestroy(): void {
    hilog.info(0x0000, 'mmm', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'mmm', '%{public}s', 'Ability onWindowStageCreate');
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'mmm', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'mmm', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'mmm', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'mmm', '%{public}s', 'Ability onForeground');
    if (BuildProfile.TARGET_NAME) {
      debugKit.onSensorAccelerometer()
    }

  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'mmm', '%{public}s', 'Ability onBackground');
    if (BuildProfile.TARGET_NAME) {
      debugKit.offSensorAccelerometer();
    }
  }
}

