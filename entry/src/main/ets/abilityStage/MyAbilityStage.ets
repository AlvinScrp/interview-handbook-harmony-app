import { appRecovery, AbilityStage } from '@kit.AbilityKit';
import { MyApp, ErroHandler } from '@ohos/common';


export default class MyAbilityStage extends AbilityStage {
  onCreate() {
    let appContext = this.context.getApplicationContext()
    MyApp.getInstance().initAppEnv(appContext)
    ErroHandler.observeError()

    appRecovery.enableAppRecovery(
      appRecovery.RestartFlag.ALWAYS_RESTART,
      appRecovery.SaveOccasionFlag.SAVE_WHEN_ERROR,
      appRecovery.SaveModeFlag.SAVE_WITH_FILE
    );
  }
}