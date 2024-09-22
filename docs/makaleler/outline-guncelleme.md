---
title: Outline Güncelleme
description: Notion alternatifi Outline projesi nasıl güncellenir
---

Daha öncesinde [Notion alternatifi outline kurulumu](notion-alternatifi-outline-kurulumu.md) ile
Outline'ın nasıl kurulduğunu öğrenmiştik. Bu makalede Outline projesinin nasıl güncelleneceğine
değineceğiz.

## Veritabanı Yedekleme

Güncellemeye başlamadan önce veritabanı yedeklemesini her ihtimale karşı yapmamız gerekmekte.
Migration yapılırken çıkabilecek herhangi bir soruna karşı elimizde yedeğin olması her zaman iyi
olacaktır. Bunun için aşağıdaki komutları girin ve veritabanını yedekleyin.

```sh
sudo -u postgres -s /bin/bash
cd ~

pg_dump outline > outline-$(date +%Y-%m-%d).sql
gzip outline-$(date +%Y-%m-%d).sql
```

Burada veritabanı ismi `outline` olacak şekilde ayarlanmış. Eğer başka bir veritabanı ismi
kullanıyorsanız bunu düzeltmeniz gerekmekte.

## Yeni Kodu Alma

Önceki kurulum belgesinde `/srv/outline` altına git yardımı ile kurulum yaptığımızı hatırlayalım.
Burada git main branchinden en son sürümü alıp, uygulamayı tekrar build etmemiz gerekmekte.

```sh
sudo fish
cd /srv/outline
git pull

export NODE_OPTIONS=--max_old_space_size=4096
yarn install --frozen-lockfile && yarn build
```

Burada sabırlı olmanız gerekmekte. Uygulamanın build edilmesi 5 ile 10 dakika kadar sürebiliyor ve
bu sürede süreci kesmemeniz gerekmekte.

##  Servislerin Yeniden Başlatılması

```sh
supervisorctl status
supervisorctl stop outline

pkill -f node

supervisorctl start outline
```

Servisin durumu hakkında bilgi almak için `/var/log/supervisor` altındaki dosyalara bakabilirsiniz.

## Veritabanı Taşıma

Uygulama ilk açıldığında veritabanı taşımalarını (database migration) otomatik olarak yapacaktır.
Bunun için ayrı bir şey yapmamıza gerek yok.

## Yedekten Geri Dönme

Olası bir problemde yedekten tekrar geri dönmek için veritabanını silip yeniden oluşturmamız
gerekiyor. Bunun için aşağıdaki komutları uygulayabilirsiniz.

```sh
sudo -u postgres -s /bin/bash
cd ~

psql
```

```sql
DROP DATABASE outline;
CREATE DATABASE outline;
```

Sonrasında yedekten dönmek için aşağıdaki komutu girin.

```sh
gunzip <OUTLINE-SQL.GZ>

psql outline < outline.sql
```

## Upload Edilen Dosyalar

Outline içerisine upload edilen dosyalar `/var/lib/outline` dizini içerisinde bulunuyor. Eğer tam
olarak taşıma yapmak istiyorsanız bu dizindeki dosyaları da taşımanız gerekmekte.
