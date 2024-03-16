---
title: IoT Görselleştirme Güncellemesi
slug: iot-gorsellestirme-guncellemesi
description: Bir önceki IoT görselleştirme yazısına güncelleme
date: 2024-03-16
categories:
    - IoT
---

[Bir önceki yazıda][previous] IoT görselleştirmenin nasıl yapılabileceğini yazmıştım. Öncesinde
[InfluxDB][influxdb]{:target="_blank"} kullanıp memnun kaldım ancak tekrar kurmak istediğimde
[Grafana][grafana]{:target="_blank"} ile InfluxDB 2.0 plugini yeterince düzgün çalışmadı. Özetle
InfluxDB 2.0 FluxQL aldı bir dile geçmiş ve burada kendi dili ile sorgu yapmamız gerekiyor. Bu da
metrikleri Grafana'dan SQL tarzında seçmenize engel oluyor. Metrikleri Grafana browser ile seçmeyi
tercih ettiğimden InfluxDB katmanını [Graphite][graphite]{:target="_blank"} ile değiştirdim.

<!-- more -->

Kullandığım `telegraf.conf` dosyasında çok bir değişikliğe gitmeye gerek kalmadı. Sadece `outputs` kısmını InfluxDB'den Graphite'a çevirdim ve Docker ile Graphite çalıştırdım.

## Docker ile Graphite

Graphite çalıştırırken konfigürasyon ve data dizinlerini volume olarak bağlamak işinize yarayacaktır. Bunun için Graphite'ı çalıştırmak için aşağıdaki komutu kullanıyorum:

```sh
#!/bin/bash

docker run -d --name graphite --restart=always \
-p 80:80 -p 2003-2004:2003-2004 -p 2023-2024:2023-2024 \
-p 8125:8125/udp -p 8126:8126 \
-v /graphite/conf:/opt/graphite/conf -v /graphite/data:/opt/graphite/storage \
-v /graphite/statsd_config:/opt/statsd/config \
graphiteapp/graphite-statsd
```

!!! note "Graphite dizini"
    Docker komutunu çalıştırmadan önce kök dizinde /graphite dizininin oluşturulmuş olduğundan emin
    olun. Dilerseniz başka bir dizin de kullanabilirsiniz ancak ben bu şekilde kullanmayı tercih
    ettim.

## Telegraf Konfigürasyonu

[ESP8266][esp8266]{:target="_blank"} ile [ESPHome][esphome]{:target="_blank"} tarafından gönderilen
metrikleri MQTT sunucusundan alan ve Graphite'a gönderen konfigürasyon aşağıda. Kısa olması
açısından yorum satırlarını kaldırdım. Tüm bir telegraf konfigürasyonu edinmek ve yorum satırlarını
görmek isterseniz `telegraf config` komutunu kullanabilirsiniz, size öntanımlı konfigürasyonu
verecektir.

```toml
[agent]
interval = "10s"
round_interval = true
metric_batch_size = 1000
metric_buffer_limit = 10000
collection_jitter = "0s"
flush_interval = "10s"
flush_jitter = "0s"
precision = ""

debug = false
quiet = false
logtarget = "file"

logfile = "/var/log/telegraf/telegraf.log"
logfile_rotation_interval = "0d"
logfile_rotation_max_size = "200MB"
logfile_rotation_max_archives = 1

hostname = ""
omit_hostname = false

[[inputs.mqtt_consumer]]
servers = ["tcp://127.0.0.1:1883"]
topics = ["+/sensor/#"]

username = "mqttuser"
password = "mqttpassword"

# Bu kısmı önemli. Data format ve type olarak bu değerleri
# vermediğimizde telegraf MQTT değerlerini okuyamıyor.
data_format = "value"
data_type = "float"

[[outputs.graphite]]
servers = ["localhost:2003"]
prefix = ""
template = "host.tags.measurement.field"

timeout = "2s"
```

[previous]:   ./2024-03-01-iot-cihazlar.md
[graphite]:   https://github.com/graphite-project/docker-graphite-statsd
[esp8266]:    https://en.wikipedia.org/wiki/ESP8266
[esphome]:    https://esphome.io
[influxdb]:   https://www.influxdata.com
[grafana]:    https://grafana.com
