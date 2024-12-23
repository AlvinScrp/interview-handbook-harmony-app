import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';

const request = axios.create({
  // baseURL: 'http://gray.webuy.ai',
  baseURL: 'http://jlgateway.gray.webuy.ai',
  timeout: 20000,
})

// 请求拦截器
request.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    // 未来需要添加 token
    // config.headers.token = token;
    const token = AppStorage.get('token') as string;
    if (token) {
      config.headers.token = token;
    }
    // daily gray 绕过接库签名
    config.headers.noSign = true;
    return config;
  }
)

// 响应拦截器
request.interceptors.response.use(
  (response: AxiosResponse) => {
    return response.data;
  },
  (error: AxiosError) => {
    return Promise.reject(error.message);
  }
)

export default class Http {
  get<T>(url: string, params?: Object) {
    return request.get<null, T>(url, {
      params
    })
  }

  post<T>(url: string, data?: Object) {
    return request.post<null, T>(url, data)
  }

  put<T>(url: string, data?: Object) {
    return request.put<null, T>(url, data)
  }

  delete<T>(url: string, params?: Object) {
    return request.delete<null, T>(url, {
      params
    })
  }
};

