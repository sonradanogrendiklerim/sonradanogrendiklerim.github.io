---
title: FreeBSD Deneyimlerim
slug: freebsd-deneyimlerim
description: Sıfırdan FreeBSD kurulumu ve kullanımı konusundaki deneyimlerim.
date: 2024-09-08
categories:
    - FreeBSD
---

FreeBSD'ye dışarıdan imrenerek baktığımı söyleyebilirim. Derli toplu bir işletim sistemi ve Linux
gibi içerisinde gereksiz yazılım barındırmıyor (systemd). Henüz production ortamında kullanma fırsat
bulamasam da MacOS altında sanal makine ile biraz deneyim edindim. Bu deneyimlerimi paylaşmak
isterim. Bu girdinin sonunda temel olarak bir FreeBSD kurulumu ve ayarları konusunda fikriniz
olacak.

<!-- more -->

## Sanal Makine Yazılımı

M serisi MacBook kullanıyorsanız sanallaştırma yazılımları konusunda biraz zorluk çekebilirsiniz.
Ben bu açıdan AArch64 tipinde sanallaştırma yapan ve kullanımı oldukça kolay olan
[UTM][utm]{:target="_blank"} kullanıyorum. Öncelikle UTM yazılımını indirin ve sisteminize kurun.

[utm]: https://mac.getutm.app

## FreeBSD İndirme

Bu blogun yazıldığı tarih itibariyle en son sürüm 14.1. [FreeBSD FTP adresinden][freebsd-ftp] CD
imajını indirin. Container imajı olmadığı için sanal makinemize CD'den kurulum yapmamız gerekmekte.
Burada dikkat etmemiz gereken nokta `aarch64` tipindeki imajı indirmemiz gerektiği. Mac işlemcimiz
de aarch64 olduğu için emüle etmeden, donanım hızlandırması ile sanal makinemizi çalıştırabilir
olacağız.

[freebsd-ftp]: https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-disc1.iso

## FreeBSD Kurulumu

UTM ile `Create a New Virtual Machine -> Virtualize -> Other -> Browse` ile indirdiğiniz CD imajını
seçin ve başlatın. Ne kadar CPU, RAM ve Disk ayıracağınız sizin takdirinizde. Ben 4 CPU, 4GB RAM ve
64GB disk ayırdım.

Burada kurulum nispeten basit, yönergeleri takip etmeniz yeterli. Sadece ZFS yerine UFS kullanarak
tüm diski kullanmayı seçin.

Kurulum bittikten sonra UTM arayüzünden CD imajını çıkarmayı unutmayın zira CD imajı takılı olduğu
zaman sürekli oradan boot etmeye çalışacaktır.

## SSH ile Erişim

Kurulum yapıldıktan sonra UTM arayüzünden kurulum esnasında girdiğiniz parola ile normal kullanıcı
olarak giriş yapın. UTM otomatik olarak IP adresi atayacaktır. Bunu görmek için `ifconfig` komutunu
kullanın ve IP adresinizi öğrenin. Sonrasında aşağıdaki komut ile SSH erişimi sağlayın.

```sh
ssh kullanici@IP-ADRESI
```

Root olarak SSH erişiminin kapalı olduğunu belirteyim.

## su - Komutu

Normal bir kullanıcıda iken root kullanıcısına geçmek istiyorsanız kullanacağınız komut. Lakin bu
komutu çalıştırmak için `wheel` grubuna dahil olmak gerekmekte. Kullanıcınız bu gruba dahil değilse
`su -` komutunu da kullanamıyorsunuz. Bunun için son kez UTM arayüzünden root olarak login olun ve
aşağıdaki komutu çalıştırarak kullanıcınızı `wheel` grubuna dahil edin.

```sh
pw usermod KULLANICI -G wheel
```

Sonrasında `su -` ile root parolasını girerek root olabilirsiniz.

## Yeni Paket Yükleme

`pkg` komutu ile binary olarak paket indirip işlemler yapabiliyoruz. Yeni paket yüklemek için
`pkg install <paketismi>` yazmanız yeterli. Paket araması yapmak içinse `pkg search` komutunu
kullanabilirsiniz.

### Temel Birtakım Paketler

Htop, dig gibi komutlar FreeBSD temel sisteminde yoklar, bunların dışarıdan yüklenmesi gerekmekte. Aşağıdaki komut ile ihtiyacım olan birkaç paketi yükledim.

```sh
su -
pkg update
pkg install htop bind-tools bat fish vim
```

## Fish Shell

Kurulum sonrası ön tanımlı olarak `sh` ile geliyor. Ben fish uygulamasının daha kullanılabilir
olduğunu düşündüğüm için FreeBSD de shell olarak fish kullanmayı tercih ettim. Bunun için
kullanıcının shell ayarını değiştirmek gerekmekte. Root olduktan sonra aşağıdaki komutu çalıştırın.

```sh
pw usermod KULLANICI -s /usr/local/bin/fish
pw usermod root -s /usr/local/bin/fish
```

Sonrasında sistemden çıkıp tekrar login olduğunuzda fish shell kullanmaya başlayacaksınız.

### ls Komutunda Renkli Çıktı

Fish öntanımlı olarak ls komutunu renkli olarak vermiyor. Bunu başarmak için `ls` için bir alias
tanımlamak gerekti. `/usr/local/etc/fish/config.fish` dosyasına aşağıdaki satırları yazın.

```sh
function ls --description 'List contents of directory'
    command ls -G $argv
end
```

### Öntanımlı Mesajı Kapatma

Her fish başlatıldığında ön tanımlı olarak karşılama mesajı gelmekte. Bunu da yine `config.fish`
içerisine aşağıdaki satırı yazarak kapatabiliyoruz.

```sh
set -U fish_greeting
```

## Python

FreeBSD içerisinde Python ayrı sürümler olarak paketlenmiş durumda. Dolayısıyla farklı Python
versiyonlarını sisteminize aynı anda yükleyebilirsiniz. Bunun için aşağıdaki komutu kullanmanız
yeterli.

```sh
pkg install python311 python310
```

Bu komut hem 3.11 hem de 3.10 sürümünü yükleyecektir. Devamında `python3.11` veya `python3.10`
komutları ile ilgili versiyonu çalıştırabilirsiniz.

Örneğin Python 3.10 için bir virtualenv oluşturmak istersek aşağıdaki komutu girmemiz yeterli
olacaktır.

```sh
python3.10 -m venv venv
source venv/bin/activate.fish
```

## Redis

```sh
pkg install redis
```

Devamında servisi `rc.conf` içerisinde aktifleştirmemiz (enable) gerekmekte. Bunun için `service
redis enable` komutunu yazmamız yeterli. Sonrasında `service redis start` ile servisi
başlatabiliyoruz ve beklediğimiz gibi herhangi bir ayar gerektirmeden çalışmakta.

## RabbitMQ

```sh
pkg install rabbitmq
```

Burada da servisi aktifleştirip başlatmamız gerekmekte.

```sh
service rabbitmq enable
service rabbitmq start
```

Sonrasında `rabbitmqctl ping` ile `rabbitmqctl` komutunu kullanabiliyor muyuz şeklinde bakmamız
gerekiyor ve muhtemelen burada hata alacaksınız.

### Erlang Cookie

`rabbitmqctl` komutunun çalışabilmesi için gerekli dosya. Bu dosya `/var/db/rabbitmq/.erlang.cookie`
içerisinde yer alıyor ve `/root` altına kopyalanması gerekiyor. Cookie dosyasını kopyaladıktan sonra
`rabbitmqctl` komutu beklendiği gibi çalışacaktır.

## Sockstat

```sh
sockstat -4
```

Linux altında `netstat -tnlp` komutunun FreeBSD karşılığı. Hangi süreçlerin hangi portları
kullandığını görmemizi sağlıyor.

## Sonuç

Şimdilik deneyimlerim bu kadar. FreeBSD genel anlamıyla eğlenceli ve tam bir işletim sistemi.
Linux'tan edindiğim birtakım alışkanlıkları bıraktıktan sonra hiç zorlanmadan kullanabildim. Örneğin
temel sistem `/usr, /bin, /usr/bin` gibi dizinlerde yer alıyor ve sonradan eklenen paketler
`/usr/local` altında yer alıyor. Dolayısıyla temel sistem ile sonradan yüklenenler arasındaki ayrımı
rahatlıkla yapabiliyoruz.

Systemd olmaması bence bir avantaj. Eskiden alışık olduğumuz servis scriptleri ile istediğimizi elde
edebiliyoruz.

Bazı paketler eski gibi görünse de sistem bir bütün olarak iyi çalışmakta. Zaten FreeBSD'nin avantajı kernel ve etrafındaki uygulamaların bütün olarak geliştirilmesi ve sunulması. Yeni bir versiyon çıktığında kolaylıkla upgrade edilebiliyor.

Performans değerlendirmesi yapacak kadar maalesef kullanmadım. Umarım ilerleyen zamanlarda
production ortamında kullanma fırsatı bulabilirim.
