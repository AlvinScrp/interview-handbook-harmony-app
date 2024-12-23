import { hilog } from '@kit.PerformanceAnalysisKit'

let isDebug = true

export class LogX {
  static setDebug(debug: boolean) {
    isDebug = debug
  }

  static d(tag: string, ...args: (string | number | boolean | object | undefined | null)[]): void {
    if (isDebug) {
      hilog.debug(0x0000, tag, args.join(' '))
    }

  }
}
