import { appRecovery, errorManager } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

export class  ErroHandler{
  static  observeError() {
  let observer: errorManager.ErrorObserver = {
    onUnhandledException(errorMsg) {
      console.log('onUnhandledException, errorMsg: ', errorMsg);
      appRecovery.restartApp();
    }
  };

  try {
    errorManager.on('error', observer);
  } catch (paramError) {
    console.error(`error: ${(paramError as BusinessError).code}, ${(paramError as BusinessError).message}`);
  }
}

}