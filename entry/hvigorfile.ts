import { hapTasks, OhosHapContext, OhosPluginId } from '@ohos/hvigor-ohos-plugin';
import { getNode } from '@ohos/hvigor'

const entryNode = getNode(__filename);
// 为此节点添加一个afterNodeEvaluate hook 在hook中修改module.json5的内容并使能
entryNode.afterNodeEvaluate(node => {
  const hapContext = node.getContext(OhosPluginId.OHOS_HAP_PLUGIN) as OhosHapContext;
  const moduleName = hapContext?.getModuleName();

  hapContext?.targets((target: Target) => {
    if (target.getTargetName() != 'daily') {
      const jsonOpt = hapContext?.getModuleJsonOpt()
      const newJsonOpt = removeRequestPermission(jsonOpt, "ohos.permission.ACCELEROMETER")
      hapContext?.setModuleJsonOpt(newJsonOpt)
    }
  });

})

// 定义移除特定条件的函数
function removeRequestPermission(
  obj: any,
  permissionName: string
): any {
  // 检查是否存在 requestPermissions 属性
  if (obj.module && Array.isArray(obj.module.requestPermissions)) {
    // 使用 filter 移除符合条件的项
    obj.module.requestPermissions = obj.module.requestPermissions.filter(
      (permission) => permission.name !== permissionName
    );
  }
  return obj;
}

export default {
  system: hapTasks, /* Built-in plugin of Hvigor. It cannot be modified. */
  plugins: []         /* Custom plugin to extend the functionality of Hvigor. */
}
