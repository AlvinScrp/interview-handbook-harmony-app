import { appTasks } from '@ohos/hvigor-ohos-plugin';

// // 导入模块
// import { hvigor, HvigorPlugin, HvigorNode } from '@ohos/hvigor';
// import { OhosHapContext, OhosPluginId, appTasks } from '@ohos/hvigor-ohos-plugin';
//
// // 实现自定义插件
// function customPlugin(): HvigorPlugin {
//   return {
//     pluginId: 'customPlugin',
//     async apply(currentNode: HvigorNode): Promise<void> {
//       console.log('hello customPlugin!');
//       hvigor.nodesEvaluated(async () => {
//         console.log('hello customPlugin! nodesEvaluated');
//         // 注册模块级任务
//         hapTask(currentNode);
//       });
//     }
//   }
// }
//
// function hapTask(currentNode: HvigorNode) {
//   console.log('hello customPlugin! hapTask');
//
//   // 等待全部节点加载完成之后获取子节点信息
//   currentNode.subNodes((node: HvigorNode) => {
//     console.log('hello customPlugin! ');
//     // const node = currentNode
//     // 获取hap模块上下文信息
//     const hapContext = node.getContext(OhosPluginId.OHOS_HAP_PLUGIN) as OhosHapContext;
//     const moduleName = hapContext?.getModuleName();
//     hapContext?.targets((target: Target) => {
//       console.log('hapContext?.targets', target.getTargetName(),);
//       const targetName = target.getTargetName();
//
//       node.registerTask({
//         // 任务名称
//         name: `${targetName}@removePermissions`,
//         // 任务执行逻辑主体函数
//         run() {
//           console.log('removePermissions Task');
//           const jsonOpt = hapContext?.getModuleJsonOpt()
//           console.log('old',jsonOpt)
//           const newJsonOpt = removeRequestPermission(jsonOpt, "ohos.permission.ACCELEROMETER")
//           newJsonOpt['module']['description'] ="测试测试"
//           console.log('new',newJsonOpt)
//           hapContext?.setModuleJsonOpt(newJsonOpt)
//           console.log('new2',hapContext?.getModuleJsonOpt())
//         },
//         // 配置前置任务依赖
//         dependencies: [`${targetName}@PackageHap`],
//         // 配置任务的后置任务依赖
//         postDependencies: [`assembleHap`]
//       });
//
//       node.registerTask({
//         // 任务名称
//         name: `${targetName}@checkPermissions`,
//         // 任务执行逻辑主体函数
//         run() {
//           console.log('checkPermissions Task');
//           const jsonOpt = hapContext?.getModuleJsonOpt()
//           console.log('old',jsonOpt)
//         },
//         // 配置前置任务依赖
//         dependencies: [`assembleHap`],
//       });
//     });
//
//   });
// }
//
// // 定义移除特定条件的函数
// function removeRequestPermission(
//   obj: any,
//   permissionName: string
// ): any {
//   // 检查是否存在 requestPermissions 属性
//   if (obj.module && Array.isArray(obj.module.requestPermissions)) {
//     // 使用 filter 移除符合条件的项
//     obj.module.requestPermissions = obj.module.requestPermissions.filter(
//       (permission) => permission.name !== permissionName
//     );
//   }
//   return obj;
// }

export default {
  system: appTasks, /* Built-in plugin of Hvigor. It cannot be modified. */
  plugins: []         /* Custom plugin to extend the functionality of Hvigor. */
}

// customPlugin()