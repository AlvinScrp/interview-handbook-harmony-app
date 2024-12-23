import { Pref } from "../utils/Pref";
import { appRecovery } from "@kit.AbilityKit";
import { LogX } from "../../../../Index";

export const Daily = 'daily', Gray = 'gray', Online = 'online'

const Key_env = "key_env"

export class MyApp {
  private env?: string | null
  private static instance: MyApp;
  private init: boolean = false
  private appContext?: Context;

  public static getInstance(): MyApp {
    if (!MyApp.instance) {
      MyApp.instance = new MyApp();
    }
    return MyApp.instance;
  }

  initAppEnv(appContext: Context) {
    this.appContext = appContext.getApplicationContext()
    this.init = true
    this.env = Pref.default().getValueSync<string>(Key_env)
    LogX.d('mmm','initAppEnv',this.env)
  }

  getAppContext(): Context | undefined {
    return this.appContext
  }

  getEnv(): string {
    if (this.env === Daily) {
      return Daily
    } else if (this.env === Gray) {
      return Gray
    } else {
      return Online
    }
  }

  switchEnv(newEnv: string) {
    LogX.d("mmm", "switchEnv", newEnv)
    Pref.default().setValueSync(Key_env, newEnv);
    appRecovery.restartApp()
  }
}
