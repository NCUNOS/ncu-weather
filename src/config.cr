WEATHER_BGS = {
  "drizzle" => [
    {
      img: "https://c1.staticflickr.com/4/3925/14333525008_43076e1768_o.jpg",
      url: "https://www.flickr.com/photos/judy19740108/14333525008",
      author: "lin Judy(快樂雲)",
      only_day: false,
      only_night: false
    }
  ],
  "shower" => [
    {
      img: "https://c3.staticflickr.com/4/3625/3491580634_60673b584d_o.jpg",
      url: "https://www.flickr.com/photos/huangandy/3491580634",
      author: "andy",
      only_day: false,
      only_night: false
    }
  ],
  "fair" => [
    {
      img: "https://c7.staticflickr.com/8/7197/6842794862_643ca96161_o.jpg",
      url: "https://www.flickr.com/photos/judy19740108/6842794862",
      author: "lin Judy(快樂雲)",
      only_day: true,
      only_night: false
    },
    {
      img: "https://c2.staticflickr.com/5/4073/4882535425_a27e76c034_o.jpg",
      url: "https://www.flickr.com/photos/lincet/4882535425",
      author: "lincet",
      only_day: false,
      only_night: true
    }
  ],
  "sunny" => [
    {
      img: "https://c8.staticflickr.com/4/3364/3226851663_e8b72ce487_o.jpg",
      url: "https://www.flickr.com/photos/weiren/3226851663",
      author: "wei-ren",
      only_day: false,
      only_night: false
    },
    {
      img: "https://c4.staticflickr.com/8/7046/6988931779_7fe5f7c44a_o.jpg",
      url: "https://www.flickr.com/photos/judy19740108/6988931779",
      author: "lin Judy(快樂雲)",
      only_day: false,
      only_night: false
    }
  ],
  "clear" => [
    {
      img: "https://c3.staticflickr.com/4/3439/3227751514_964c5fa7cc_o.jpg",
      url: "https://www.flickr.com/photos/weiren/3227751514/",
      author: "wei-ren",
      only_day: false,
      only_night: false
    },
    {
      img: "https://c2.staticflickr.com/9/8242/8581403033_08762c0b21_k.jpg",
      # img: "https://c2.staticflickr.com/9/8242/8581403033_8969a2004f_o.jpg",
      url: "https://www.flickr.com/photos/bravesheng/8581403033",
      author: "Vincent Chien",
      only_day: false,
      only_night: true
    }
  ],
  "partly_cloudy" => [
    {
      img: "https://c5.staticflickr.com/9/8866/18744923316_506d1ea0d0_o.jpg",
      url: "https://www.flickr.com/photos/tsaiian/18744923316",
      author: "tsaiian",
      only_day: true,
      only_night: false
    },
    {
      img: "https://c7.staticflickr.com/4/3359/3215320590_4ab78ea467_o.jpg",
      url: "https://www.flickr.com/photos/weiren/3215320590",
      author: "wei-ren",
      only_day: true,
      only_night: false
    },
    {
      img: "https://c1.staticflickr.com/4/3434/3227730640_0f6bf06d35_o.jpg",
      url: "https://www.flickr.com/photos/weiren/3227730640",
      author: "wei-ren",
      only_day: false,
      only_night: true
    }
  ],
  "thundershower" => [
    {
      img: "https://c3.staticflickr.com/4/3625/3491580634_60673b584d_o.jpg",
      url: "https://www.flickr.com/photos/huangandy/3491580634",
      author: "andy",
      only_day: false,
      only_night: false
    }
  ],
  "mostly_cloudy" => [
    {
      img: "https://c2.staticflickr.com/4/3332/3226884353_0ed7064a58_o.jpg",
      url: "https://www.flickr.com/photos/weiren/3226884353",
      author: "wei-ren",
      only_day: true,
      only_night: false
    },
    {
      img: "https://c7.staticflickr.com/4/3355/3316697182_d60e7e07c5_o.jpg",
      url: "https://www.flickr.com/photos/weiren/3316697182",
      author: "wei-ren",
      only_day: false,
      only_night: true
    }
  ],
  "cloudy" => [
    {
      img: "https://c2.staticflickr.com/4/3362/3226865489_30fab9fbdb_o.jpg",
      url: "https://www.flickr.com/photos/weiren/3226865489",
      author: "wei-ren",
      only_day: false,
      only_night: false
    }
  ]
}

DUMMY_BG = {
  img: "about:blank",
  url: "about:blank",
  author: "",
  only_day: false,
  only_night: false
}

DUMMY_WEATHER = {
  time:           "unknown",
  weather:        "unknown",
  temperature:    0.0,
  humidity:       0.0,
  wind_direction: 0.0,
  wind_speed:     0.0,
  pressure:       0.0,
  rain:           0.0,
  day_or_night:   "unknown",
  error: true
}

def get_weather_cht_name(name)
  case name
  when "drizzle"
    "毛毛雨"
  when "shower"
    "有雨"
  when "fair"
    "晴時有雲"
  when "sunny"
    "晴朗"
  when "clear"
    "無雲"
  when "partly_cloudy"
    "局部有雲"
  when "thundershower"
    "雷陣雨"
  when "mostly_cloudy"
    "多雲時晴"
  when "cloudy"
    "陰天"
  when "unknown"
    "無資料"
  else
    ""
  end
end
