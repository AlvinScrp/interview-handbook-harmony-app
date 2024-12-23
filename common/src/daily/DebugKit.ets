import { sensor } from "@kit.SensorServiceKit";
import { promptAction, router } from "@kit.ArkUI";
import { LogX } from "../main/ets/utils/log";

import('../main/ets/common/pages/DebugKitPage');

class DebugKit {
  private SWING_VAL: number = 14;
  offSensorAccelerometer(){
    sensor.off(sensor.SensorId.ACCELEROMETER);
  }
  onSensorAccelerometer() {
    sensor.on(sensor.SensorId.ACCELEROMETER, (data: sensor.AccelerometerResponse) => {

      let x = Math.abs(data.x);
      let y = Math.abs(data.y);
      let z = Math.abs(data.z);

      let message = "x : " + x + "  y: " + y + " z: " + z;

      if (x > this.SWING_VAL || y > this.SWING_VAL || z > this.SWING_VAL) {
        promptAction.showToast({
          message: "手机正在摇一摇！"
        })
        LogX.d('mmm', message)

          router.pushNamedRoute({ name:  'DebugKitPage' },router.RouterMode.Single, (err) => {
            if (err) {
              LogX.d('mmm', 'Failed to load the content. Cause:', JSON.stringify(err) ?? '');
              return;
            }
            LogX.d('mmm', 'Succeeded in loading the content.');
          });
      }

    }, {
      interval: 50_00000000
    }); // 1_000000000 ns =1s  设置间隔为 5 s
  }

  getName = () => "DebugKit-daily"
}

let debugKit = new DebugKit();

export default debugKit;
