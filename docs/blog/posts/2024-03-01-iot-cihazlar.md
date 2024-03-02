---
title: IoT Cihazlar, ESP8266 ve Görselleştirilmesi
slug: iot-cihazlar-esp8266-ve-gorsellestirilmesi
description: IoT cihazlarlardan metrik alma, ESP8266 ve ne şekilde gösterilebileceği üzerine.
date: 2024-03-01
categories:
    - IoT
---

Evlerimizdeki neredeyse bütün cihazlar internete bağlı. Bu cihazlar bir firma tarafından üretiliyor
ve esasında üzerinde pek de hakimiyetimiz yok. Örneğin basit bir sıcaklık / nem ölçen cihaz bile
üretici bağımlı. Eğer üretici ortadan kaybolursa bu cihaz çalışmaz hale gelecek zira arka tarafında
bu metriklerin toplandığı ve mobil uygulama aracılığı ile görselleştirildiği bir altyapı mevcut.

<!-- more -->

Bu altyapıyı kendimiz de oluşturabiliyoruz. Hatta kendi sıcaklık ölçen cihazımızı yapmak hiç de zor
değil. [ESP8266][esp8266]{:target="_blank"} barındıran [NodeMCU v3][nodemcu]{:target="_blank"}
geliştirme kartı ve [SHT31][sht31]{:target="_blank"} kullanarak internete bağlı, aldığı bilgileri
uzak bir sunucuya gönderen ve sonrasında görselleştirileceği bir yapı kurmak eli bu işlere değmiş
biri için gayet yapılabilir.

Ben buna benzer bir yapıyı odalardaki sıcaklığı takip etmek için kurdum. Bunun için InfluxDB, Telegraf, Mosquitto ve Grafana kullandım. Kısaca açıklayacak olursam:

- __[InfluxDB][influxdb]{:target="_blank"}__: Metriklerin toplandığı veri tabanı. Cihazlardan
  aldığımız metrikler bu sunucuya yazılıyor ve sonrasında sorgulanıyor. Bunu zaman tabanlı bilgiler
  için bir MySQL veya PostgreSQL şeklinde düşünebilirsiniz
- __[Mosquitto][mosquitto]{:target="_blank"}__: Minik cihazların bağlanıp ölçüm yaptıkları değeri
  gönderdikleri sunucu. Bu sunucu arada bir mesajcı görevi görüyor ve buna bağlanan diğer bütün
  istemcilere alınan mesajı gönderiyor. Bu yapıya PubSub denmekte.
- __[Telegraf][telegraf]{:target="_blank"}__: Mosquitto'ya bağlanıp IoT cihazlardan gelen mesajları
  InfluxDB'ye yazan ara katman. Cihazlar çok küçük olduğundan ve zar zor internete bağlandığından
  direkt olarak InfluxDB'ye yazamadığımız için böyle bir çözüm gerekmekte.
- __[Grafana][grafana]{:target="_blank"}__: Verilerin görselleştirildiği yer. InfluxDB'yi sorgulayıp
  ilgili görselleri çıkarıyor.

Esasında yaptığımız şey cihaz internete bağlanabiliyorsa ve Mosquitto'ya veri gönderebiliyorsa, bu
alınan verileri görselleştirmek. [ESPHome][esphome]{:target="_blank"} projesi ile elimizde bulunan
[ESP8266][esp8266]{:target="_blank"}'yı MQTT ([Mosquitto][mosquitto]{:target="_blank"}) kullanacak
şekilde programladığımızda bunu elde etmiş oluyoruz. Cihaz açıldığında önce kablosuz ağa bağlanıyor,
sonrasında MQTT sunucusuna bağlanıp ölçümünü buraya gönderiyor. Burdan sonra da Telegraf, Influxdb
ve Grafana kullanarak görselleştiriyoruz.

Aslında kullandığımız IoT cihazların yapısı aşağı yukarı bu şekilde. Biz sadece arka tarafındaki
altyapıyı göremiyoruz. Elimizdeki cihazların tek görevi işini olabildiğince sade yapıp internete
bilgi aktarmak.

Yazının başında bu altyapının şirketlerin kontrolünde olduğunu ve her an çalışmayabileceğini
söylemiştim. Eğer zamanınız ve bilginiz varsa bu tarz sensör verilerini almak için
[ESP8266][esp8266]{:target="_blank"} çok güzel bir platform. Birçok sensör bağlanabiliyor ve
[ESPHome][esphome]{:target="_blank"} ile [OTA][ota]{:target="_blank"} özelliği sayesinde cihazı
bilgisayara bağlamadan ağ üzerinden programlayabiliyorsunuz. Geliştirme aşamasında bu çok büyük bir
kolaylık sağlıyor. Sonrasında InfluxDB, Telegraf, Mosquitto ve Grafana ile güzel bir şekilde de
görselleştirebiliyoruz.

Burada tek eksik kullanıcı dostu olmaması. Tak çalıştır şeklinde bir altyapı tabii ki kurulabilir ama bunu para için yapmadığımız için kendi yağımızda kavruluyoruz. Grafana'nın mobil arayüzü gayet yeterli olduğu için pek de ihtiyacımız yok aslında.

Umarım buradaki anahtar kelimeler sizlere yardımcı olur ve kendi sıcaklık / nem sensörünüzü,
devamında arka tarafındaki altyapınızı kurmanız için bir yol açar. Maalesef bütün bu sunucuları ve
altyapıyı baştan kurup yazıya dökmek için vaktim şimdilik yok. Umarım ben de baştan sona sıcaklık /
nem sensörü ile beraber görselleştirme yazısı yazmak için zaman bulabilirim.

[influxdb]:   https://www.influxdata.com
[mosquitto]:  http://mosquitto.org
[telegraf]:   https://www.influxdata.com/time-series-platform/telegraf/
[grafana]:    https://grafana.com
[esp8266]:    https://en.wikipedia.org/wiki/ESP8266
[sht31]:      https://www.direnc.net/sht31-sicaklik-ve-nem-sensoru-modulu-i2c-13815
[esphome]:    https://esphome.io
[ota]:        https://en.wikipedia.org/wiki/Over-the-air_update
[nodemcu]:    https://www.robotistan.com/nodemcu-lolin-esp8266-gelistirme-karti-usb-chip-ch340
