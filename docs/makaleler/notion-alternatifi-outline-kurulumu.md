---
title: "Notion Alternatifi: Outline Kurulumu"
description: Notion'a alternatif belge yönetim yazılmı Outline kurulumu
---

Notion belge yönetimi için yararlı bir araç ancak küçük takımlar için pahalı olabiliyor.
[Ecommerc.io][ecommercio]{:target="_blank"} olarak ilk önce notion kullanmış olsak da takım
büyüdükçe her bir kişi için aylık $10 fazla gelmeye başladı. Bu açıdan alternatif yazılımlara
yöneldik ve Notion'u aratmayan [Outline][outline]{:target="_blank"} projesini bulduk.

Bu belge Outline'ın nasıl kurulacağını anlatır.

[ecommercio]: https://ecommerc.io/
[outline]: https://getoutline.com

## Gereklilikler

- Ubuntu 22.04 sanal makine (c6g.medium)
- DNS kaydı
- Caddy web sunucusu
- Supervisor
- Node 20
- Yarn
- Redis
- PostgreSQL
- Google ile kimlik doğrulama

## DNS Kaydı

Öncelikle DNS kaydı edinmelisiniz. Outline Google kimlik doğrulaması kullandığı için kimlik
doğrulaması sonrasında geriye döneceği bir adrese sahip olması gerekiyor. Maalesef sadece kullanıcı
adı ve parola ile yetkilendirmeyi desteklemiyor. Bu açıdan bir DNS kaydımızın kurulum başlamadan
olması gerekmekte. Bu DNS kaydına şimdilik `wiki.example.com` diyebiliriz. Makalenin ilerleyen
yerlerinde bu adres kullanılacaktır, uygun yerlerde bunları değiştirin.

## Ubuntu Güncellemesi

EC2 ya da DigitalOcean olsun, kurulum yaptıktan sonra ilk işimizin güncelleme olması iyi bir pratik.
Aşağıdaki komut ile güncelleme yapın.

```sh
sudo apt update
sudo apt upgrade
```

Güncelleme yaptıktan sonra DNS kaydının çalışır olduğundan emin olun. Aynı zamanda EC2 için güvenlik
gruplarının düzgün konfigüre edildiğinden emin olun. Port 80 ve 443'e izin vermeniz gerekmekte.

## Gerekli Paketlerin Yüklenmesi

### Caddy Web Sunucusu

Reverse proxy olarak görev yapacak ve bizim için SSL sertifikasını otomatik olarak oluşturacak
sunucuyu kuralım. Bu sunucu Ubuntu'nun kendi repolarında yer almıyor ve
[kurulum sayfasındaki][caddy-install]{:target="_blank"} yönergeleri takip etmemiz gerekiyor.

Kurulum yönergelerini takip edip kurduktan sonra `/etc/caddy/Caddyfile` oluştuğundan ve `service
caddy status` komutu ile çalışır olduğundan emin olun.

Bu aşamada `wiki.example.com` adresine gittiğiniz zaman Caddy'nin ön tanımlı sayfasını görüyor
olmanız gerekmekte. Eğer bunu göremiyorsanız DNS kaydınızda ya da güvenlik izinlerinde bir sorun var
demektir. Geriye dönüp bunların doğru şekilde ayarlandığından emin olun.

[caddy-install]: https://caddyserver.com/docs/install#debian-ubuntu-raspbian

### Node 20

Ubuntu'nun ön tanımlı repolarında node versiyonu maalesef çok eski ve Outline bu node versiyonu ile
çalışmıyor. Bunun yerine `nodesource` reposundan Node 20 kurulumu yapılması gerekmekte.

```sh
curl -sL https://deb.nodesource.com/setup_20.x -o /tmp/nodesource_20x.sh
sudo bash /tmp/nodesource_20x.sh

sudo apt install nodejs -y
```

Bu komut sonrası nodejs versiyonun 20 olduğunu `node --version` ile teyit edin ve devamında `yarn`
paketini yükleyin.

```sh
npm install -g yarn
```

###  PostgreSQL

```sh
apt install postgresql
```

Kurulum yaptıktan sonra outline için yeni kullanıcı eklenmesi ve bu kullanıcının veritabanı
oluşturma yetkisine sahip olması gerekmekte. Bunun için `postgres` kullanıcısı ile veritabanına
erişelim ve kullanıcı oluşturalım. Buradaki parolayı daha güçlü bir parola ile değiştirmek
isteyebilirsiniz.

```sh
sudo -u postgres -s psql
```

```sql
CREATE USER outline WITH ENCRYPTED PASSWORD 'outline';
ALTER USER outline CREATEDB;
```

### Redis

```sh
sudo apt install redis
```

### Supervisor

Outline sunucusunu başlatacak ve arkada çalışmasını sağlayacak uygulama.

```sh
sudo apt install supervisor
```

### Google OAuth

Uygulamanın çalışabilmesi için `Google Client ID` ve `Google Client Secret` ortam değişkenlerinin
tanımlı olması gerekiyor. Bunun için [OAuth Client ID][oauth-client]{:target="_blank"} sayfasına
gidip yeni bir ID oluşturun. `Redirect URL` kısmına DNS kaydınızı yazın.

```plain
https://wiki.example.com/auth/google.callback
```

[oauth-client]: https://console.cloud.google.com/apis/credentials

## Outline Kurulumu

Bütün gereklilikleri kurduktan sonra [outline kurulumuna][outline-install]{:target="_blank"}
geçebiliriz. Tek bir sunucuda, sadece outline çalışacağı için root ile kurulum yapılıyor. Bunun
yerine outline için ayrı bir kullanıcı açıp ilerleyebilirsiniz ancak ben bu yolu tercih etmedim.

```sh
cd /srv
sudo su

git clone https://github.com/outline/outline.git

yarn install --frozen-lockfile && yarn build
```

Bu aşamada uygulamanın derlenmesini bekliyoruz. `c6g.medium` instance ile bu benim için 5 dakika
civarında sürüyor. Eğer küçük bir instance kullanıyorsanız bu aşamada biraz sabırlı olmak gerekiyor.

[outline-install]: https://docs.getoutline.com/s/hosting/doc/from-source-BlBxrNzMIP

### Ortam Değişkenleri

`.env` içerisindeki alanları doldurun. Burada veritabanı, secret ve Google OAuth bilgilerini
doldurmanız gerekmekte. Slack kullanmayacaksanız slack ile ilgili alanları yorum satırına alın zira
dolu olduğu ve doğru bilgiler girilmediği zaman uygulama hata vermekte.

### Veritabanı

Bu aşamada artık veritabanı migration işlemine geçebiliriz. Aşağıdaki komutlarla bunu
gerçekleştirin.

```sh
yarn sequelize db:create
yarn sequelize db:migrate
```

### Uygulamayı Çalıştırma

Her şey yolunda gittiyse artık uygulamayı başlatabiliriz. Aşağıdaki komut ile Outline'ın çalıştığından emin olun.

```sh
yarn start
```

Uygulamanın çalıştığını teyit ettikten sonra `ctrl-c` ile sonlandırın. Bunu supervisor ile
çalıştıracağız.

## Konfigürasyon

### Supervisor

Outline'ı arkaplanda çalıştırmak için gerekli. `/etc/supervisor/conf.d/outline.conf` dosyasını
oluşturun ve içerisine aşağıdaki satırları yazın.

```plain
[program:outline]
stopwaitsecs = 120
directory=/srv/outline
command=/usr/bin/yarn start

stdout_logfile=/var/log/supervisor/%(program_name)s.out.log
stderr_logfile=/var/log/supervisor/%(program_name)s.err.log
```

Sonrasında `supervisorctrl start outline` ile uygulamayı çalıştırın.

!!! note "Supervisor ile servisi durdurma"
    Sebebini bilmediğim bir şekilde supervisor ile outline servisi durdurulamıyor.
    `superviorctrl stop outline` komutu ile supervisorde durmuş görünüyor ancak servis çalışmaya
    devam ediyor. Servisi durdurma sırasında supervisor komutunu girdikten sonra `node` sürecini
    kill etmek gerekmekte. Bunun için `superviorctrl stop outline` sonrası `pkill -f node` komutunu
    çalıştırın. `ps aux | grep node` komutu ile servisin kapanıp kapanmadığını teyit edebilirsiniz.

### Caddy

Bizim için SSL sertifikalarını oluşturacak ve reverse proxy görevi görecek. Bunun için
`/etc/caddy/Caddyfile` dosyasını aşağıdaki şekilde düzenleyin.

```plain
wiki.example.com {
 reverse_proxy localhost:3000
}
```

Sonrasında servisi `service caddy restart` komutu ile yeniden başlatın.

### Admin Kullanıcısı

Outline'a ilk kayıt olan kullanıcı admin yetkilerine sahip oluyor. Eğer organizasyonunuzda
kullanıcıların sadece tek bir domain ile kayıt olmalarını istiyorsanız `Ayarlar - Güvenlik`
kısmından domain isminizi yazın. Böylelikle sadece tek bir e-posta adresi uzantısına sahip olanlar
kayıt olacaktır. Detaylı kullanım belgesi için [outline belgelerine][outline-doc] göz atabilirsiniz.

[outline-doc]: https://docs.getoutline.com/s/guide

## Sonuç

Tebrikler. Artık notion benzeri bir wiki sayfasına sahipsiniz. Outline notion'un sunduğu birçok özelliği sunabilmekte. Aynı anda düzenleme, temiz arayüz bunlardan birkaç tanesi. `c6g.medium` aylık $28 ve bu da notion'da 3 kişinin ücretine denk geliyor.
