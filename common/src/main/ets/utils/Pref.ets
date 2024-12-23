/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { preferences } from '@kit.ArkData';
import { MyApp } from '../../../../Index';

const PREFERENCES_NAME_DEfault: string = 'InterviewHandBookStore';

export class Pref {
  private preferences?: preferences.Preferences;
  private static instance: Pref;
  private storeNameInner: string = PREFERENCES_NAME_DEfault

  private constructor(storeName: string) {
    this.storeNameInner = storeName
    this.initPreferencesSync(storeName)
  }

  private initPreferencesSync(storeName: string) {
    // let context = getContext() ;
    let ctx = MyApp.getInstance().getAppContext()
    if (ctx) {
      this.preferences = preferences.getPreferencesSync(ctx, { name: storeName })
    }
  }

  public static default(): Pref {
    if (!Pref.instance) {
      Pref.instance = new Pref(PREFERENCES_NAME_DEfault);
    }
    return Pref.instance;
  }

  public static createSync(storeName: string): Pref {
    return new Pref(storeName)
  }


  setValueSync<T>(key: string, value: T): void {
    if (!this.preferences) {
      this.initPreferencesSync(this.storeNameInner)
    }
    this.preferences?.putSync(key, JSON.stringify(value))
    this.preferences?.flush()
  }

  getValueSync<T>(key: string): T | null {
    if (!this.preferences) {
      this.initPreferencesSync(this.storeNameInner)
    }
    let res = this.preferences?.getSync(key, '')
    let value: T | null = null;
    if (res) {
      value = JSON.parse(res as string) as T;
    }
    return value;

  }

  hasSync(key: string): boolean | undefined {
    if (!this.preferences) {
      this.initPreferencesSync(this.storeNameInner)
    }

    return this.preferences?.hasSync(key);

  }

  deleteSync(key: string): void {
    if (!this.preferences) {
      this.initPreferencesSync(this.storeNameInner)
    }
    this.preferences?.deleteSync(key)
    this.preferences?.flush()
  }
}
