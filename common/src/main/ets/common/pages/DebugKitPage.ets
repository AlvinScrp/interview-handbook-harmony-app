import { DebugKitView } from 'common/DebugKitView'

@Entry({ routeName: 'DebugKitPage' })
@Component
struct DebugKitPage {
  build() {
    Column() {
      DebugKitView()
    }
  }
}