# NCU Weather

由[中央大學網路開源社](http://www.nos.ncu.edu.tw)提供的中大氣象 API。

資料來源：[國立中央大學大氣科學系大氣邊界層暨空氣污染實驗室 (Planetary Boundary Layer & Air Pollution Lab.)](http://pblap.atm.ncu.edu.tw)

Site: http://weather.nos.ncu.edu.tw

Simple API: http://weather.nos.ncu.edu.tw/api

Inspired by [阿屜報氣象](https://github.com/rschiang/ntu-weather), [Yahoo! Weather](http://weather.yahoo.com), [臺灣氣象資訊](http://weather.json.tw/)

## API 結構

本 api 為一 json 格式資料，格式如下。

```
{
  "version": "1.0",
  "data": {
    "time":           "06/12 16:47",
    "weather":        "clear",
    "temperature":    26.7,
    "humidity":       13.7,
    "wind_direction": 278.4,
    "wind_speed":     16.3,
    "pressure":       1010.7,
    "rain":           17.6,
    "day_or_night":   "day",
    "error": false
  }
}
```

| Name    | Type   | Description                |
|    ---: | :---   | :---                       |
| version | String | API 版本，目前只會是 `1.0` |
| data    | Object | 氣象資料，詳見下方說明     |

### data 結構

| Name           | Type    | Description                          |
|           ---: | :---    | :---                                 |
| time           | String  | 觀測時間，格式為 `%m/%d %H:%M`       |
| weather        | String  | 天氣種類，詳見下方說明               |
| temperature    | Float   | 氣溫，單位為 `攝氏`                  |
| humidity       | Float   | 相對溼度，單位為 `%`                 |
| wind_direction | Float   | 風向，單位為 `度`                    |
| wind_speed     | Float   | 風速，單位為 `m/s`                   |
| pressure       | Float   | 氣壓，單位為 `hPa`                   |
| rain           | Float   | 降雨，單位為 `mm/hr`                 |
| day_or_night   | String  | 晝夜狀態，分別以 `day`、`nignt` 表示 |
| error          | Boolean | 若為真，表示無資料或無法獲取最近資料 |

### weather 種類

| Value         | Description |
|          ---: | :---        |
| drizzle       | 毛毛雨      |
| shower        | 有雨        |
| fair          | 晴時有雲    |
| sunny         | 晴朗        |
| clear         | 無雲        |
| partly_cloudy | 局部有雲    |
| thundershower | 雷陣雨      |
| mostly_cloudy | 多雲時晴    |
| cloudy        | 陰天        |
| unknown       | 無資料      |

## License

本程式以 [MIT License](LICENSE) 授權釋出。

[filckr logo](public/flickr@2x.png) 為 [Yahoo! Inc.](http://www.yahoo.com) 版權所有。

背景圖片皆從 flickr 上有 CC 授權之圖片取得。

[亞掰](https://www.flickr.com/photos/32655493@N06/)之照片由版權擁有者另行[授權](https://www.facebook.com/david50407/posts/1154650084557318?comment_id=1154681987887461&comment_tracking=%7B%22tn%22%3A%22R2%22%7D)（[截圖](http://i.imgur.com/QhJQcf7.png)）。

圖片等素材以 [CC BY-NC-SA 3.0 TW](http://creativecommons.org/licenses/by-nc-sa/3.0/tw/) 授權。
