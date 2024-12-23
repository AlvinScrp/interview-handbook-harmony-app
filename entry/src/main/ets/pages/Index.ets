import { TabBarModel, TabBarList } from '../models/TabBars';
import {getName} from 'entry/Test';

import  * as Build from  'BuildProfile'
@Entry
@Component
struct Index {
  @State
  activeIndex: number = 0
  tabList: TabBarModel[] = TabBarList

  build() {
    Column() {
      Text(`${Build.BUILD_MODE_NAME} ${Build.TARGET_NAME} ${Build.PRODUCT_NAME}`)
      Text(getName())
      Tabs({ index: this.activeIndex }) {
        ForEach(this.tabList, (item: TabBarModel, i) => {
          TabContent() {
            Text(item.label)
          }
          .tabBar(this.TabBarBuilder(item, i))
        })
      }
      .divider({ strokeWidth: 0.2, color: 0xFF979797 })
      .barPosition(BarPosition.End)
      .scrollable(false)
      // .onChange((index) => this.activeIndex = index)
      .onTabBarClick((index)=> this.activeIndex =index)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xFFFFFFFF)
  }

  @Builder
  TabBarBuilder(item: TabBarModel, index: number) {
    Column({ space: 5 }) {
      Image(this.activeIndex === index ? item.activeIcon : item.defaultIcon)
        .width(24)
        .aspectRatio(1)
      Text(item.label)
        .fontSize(12)
        .fontColor(this.activeIndex === index ? 0xFF000000 : 0xFF979797)
    }
  }
}