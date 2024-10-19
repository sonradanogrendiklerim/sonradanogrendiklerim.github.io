---
title: DevPi ile Özel PyPI Sunucusu Kurulumu
description: Şirket içerisinde kendinize özel PyPI paket sunucusu nasıl kurulur
---

Python yazan bir şirketteyseniz belirli bir süre sonra kendinize göre oluşturduğunuz kütüphanelerin
dağıtımı problem olmaya başlıyor. Bunları git üzerinden sunmak birer çözüm olsa da bazı zamanlarda
pip bu bağımlılıkları çözemiyor ve hata verebiliyor. Bunların genel çözümü kendinize özel bir PyPi sunucusu kurarak bu paketleri kendi sunucunuzda dağıtmak.

Bu yazıda [devpi][devpi]{:target="_blank"} kullanarak nasıl kendi paket sunucumuzu konfigüre
edeceğimizi ve yönetebileceğimizi göreceğiz.

[devpi]: https://doc.devpi.net/

## İhtiyaçlar

- Ubuntu 24.04 sunucu
- DNS kaydı
- Python
- Caddy web sunucusu
- Supervisor
- DevPi

### Ubuntu 24.04

AWS ya da tercih edeceğiniz herhangi bir bulut servis sağlayıcısından bir sunucu edinin. Sunucuda 2
CPU ve 2GB ram olması yeterli olacaktır. DevPi sunucusu aynı zamanda cache yaptığı için disk olarak
100GB ayırmanız yararınıza olacaktır. Eğer yetmezse ilerde diski arttırabilirsiniz.

Kurulum yaptıktan sonra Ubuntu güncellemesi yapmayı ihmal etmeyin.

```sh
sudo apt-get update
sudo apt-get upgrade
```

### DNS Kaydı

PyPi sunucusunun DNS kaydına ihtiyacı var. Bu DNS adresini çeşitli konfigürasyon dosyalarına
yazacağız ve bu açıdan bir DNS adresinizin olması gerekiyor. Bunun için `pypi.sirketismi.com` gibi
bir alan adını tercih edebilirsiniz.

Ubuntu kurulumu yaptıktan sonra DNS adresinizi buraya yönlendirin ve çalıştığından emin olun.

### Python Kurulumu

Aşağıdaki komut ile Python kurulumunu gerçekleştirin.

```sh
sudo apt install python3.12 python3.12-venv
```

### Caddy Kurulumu

SSL sertifikalarını otomatik olarak yönettiği için web sunucusu tercihimiz Caddy olacak. Bunun için
[Caddy kurulum belgesi][caddy-install]{:target="_blank"}'ni ziyaret edin ve oradaki yönergeleri
izleyerek kurulum yapın.

[caddy-install]: https://caddyserver.com/docs/install#debian-ubuntu-raspbian

### Supervisor

DevPi sunucusunu yönetmek için ihtiyacımız olan yazılım. Aşağıdaki komut ile yükleyin.

```sh
sudo apt install supervisor
```

## DevPi Kurulumu

Kurulumu ubuntu kullanıcısında, ev dizininde yapacağız. Benim test ettiğim VM içerisindeki kullanıcı
ismim `eren`, yazının ilerleyen bölümlerinde kullanıcı ismi olarak bunu görebilirsiniz. Siz
kendinize göre bu kullanıcı ismini ve ev dizinini değiştirin.

### Virtual Environment Oluşturma

```sh
mkdir -p ~/src/devpi
cd ~/src/devpi

python3 -m venv venv

source venv/bin/activate
```

### DevPi Paketlerini Kurma

Sanal Python ortamını aktive ettikten sonra aşağıdaki komut ile ilgili paketleri yükleyin.

```sh
pip install devpi-server devpi-client devpi-web
```

### DevPi Dosyalarını Oluşturma

Kurulum öncesinde aşağıdaki dosyayı `config.yaml` olarak kaydedin. Dizinleri kendi ev dizininize
göre değiştirmeniz gerekmektedir.

```yaml
devpi-server:
  serverdir: /home/eren.linux/src/devpi/server
  secretfile: /home/eren.linux/src/devpi/secret
  host: localhost
  port: 4040
```

Sonrasında aşağıdaki 2 komut ile devpi dosyalarını oluşturun.

```sh
devpi-init -c config.yaml
devpi-gen-secret -c config.yaml
```

Sunucunun artık çalışıyor olması gerekli. Bunu da aşağıdaki komut ile teyit edebilirsiniz.

```sh
devpi-server -c config.yaml
```

<http://localhost:4040> adresinden sunulacaktır.

### Yeni Kullanıcı ve Index Oluşturma

Paketleri devops kullanıcı altında yayınlayacağız. Bu açıdan devops kullanıcısı ve parolası
gerekmekte. Bu paroları bu şekilde bırakmayıp değiştirmenizi öneririm.

```sh
devpi use http://localhost:4040

devpi user -c devops password=devops
devpi login devops
devpi index -c pypi bases=root/pypi
```

!!! note "Kullanıcı Parolası"
    Buradaki kullanıcı adı ve parola ile ilerde ayarlayacağımız Caddy HTTP Basic Auth kullanıcı adı
    ve parolasının aynı olması gerekmekte. Yoksa twine ve uv gibi araçlar auth hatası verip paket
    yükleyememekte.

### Supervisor Konfigürasyonu

`/etc/supervisor/conf.d/devpi.conf` dosyasını oluşturun ve içerisine aşağıdaki satırları yazın.

```plain
[program:devpi]
directory = /home/eren.linux/src/devpi
command = /home/eren.linux/src/devpi/venv/bin/devpi-server -c config.yaml
user = eren

stdout_logfile=/var/log/supervisor/devpi.log
redirect_stderr=true
```

Sonrasında `supervisorctl reread` ve `supervisorctl update` komutları ile ilgili değişiklikten
supervisor'un haberdar olmasını sağlayın. `supervisorctl status` komutu ile servisin durumunu
öğrenebilirsiniz. Herhangi bir problem durumunda log dosyasına da bakabilirsiniz.

### Caddy Konfigürasyonu

Caddy ile http basic auth yardımıyla sadece bizim erişebileceğimiz şekilde sunucuyu konfigüre
edeceğiz. Şirket içerisinde kullanacağımız ve dışarıya açık olmayacağı için bu noktada basic auth
tercih ediyoruz.

Öncelikle yukakarıda oluşturduğumuz `devops` kullanıcısı ile aynı parolaya sahip olacak şekilde
parola oluşturmamız gerekmekte. Bunun için aşağıdaki komutu girin ve belirleyeceğiniz parolayı
yazın. Örnek olması açısından burada `devops` parolası kullanılacaktır.

```sh
caddy hash-password
```

`/etc/caddy/Caddyfile` dosyasını düzenleyin ve aşağıdaki satırları ekleyin. Burada DNS kaydınız daha
öncesinde belirlediğiniz DNS kaydı olması gerekiyor. `pypi.sirketismi.com` kısmını ilgili şekilde
değiştiriniz.

```plain
pypi.sirketismi.com {
  basic_auth {
    devops $2a$14$AQ3meWulTcxq0VLYTNkE.eg4Bn3VtwFq.WhhJOhqbfEMePod3v54O
  }

  reverse_proxy :4040
}
```

Bu ayarlarla birlikte basic auth olacak şekilde Caddy sunucusunu konfigüre etmiş olacaksınız.
Çalıştığını teyit etmek için `pypi.sirketismi.com` adresini ziyaret ediniz.

!!! warning "basic_auth Direktifi"
    Caddy'nin önceki sürümlerinde `basic_auth` direktifi yerine `basicauth` kullanılıyor. Bunu
    dikkate alarak kullandığınız Caddy sürümüne göre düzenleyiniz.

## Yeni PyPI Sunucusunu Kullanmak

Buraya kadar gelmişseniz PyPI sunucusunun kurulduğunu teyit etmişsiniz demektir. Bu bölümde yeni
paketlerin nasıl kurulacağını ve `pip` ile yeni indexin nasıl kullanılacağına değineceğiz.

### Twine ile Paket Yüklemek

[Twine][twine]{:target="_blank"} PyPI ile etkileşim sağlayan bir uygulama. Bu uygulama ile yeni
kurduğumuz sunucuyu kullanmak için birkaç ayar yapmamız gerekmekte. Bunun için `~/.pypirc` dosyasını
düzenlemeye ihtiyacımız var. Bu dosyayı açın ve aşağıdaki satırları kendinize göre değiştirerek
yazın.

```ini
[distutils]
index-servers =
    sirket

[sirket]
repository = https://pypi.sirketismi.com/devops/pypi
username = devops
password = devops
```

Sonrasında göndermek istediğiniz Python modülünüze gelin ve bunu `python -m build` ile oluşturun. Sonrasında aşağıdaki komut ile bunu yeni kurduğumuz index'e gönderebilirsiniz.

```sh
twine upload -r sirket dist/*
```

Bu komuttaki `sirket` değerinin, `.pypirc` içerisindeki `sirket` olduğunu hatırlayalım.

[twine]: https://twine.readthedocs.io/en/stable/

### Pip ile PyPI Sunucusunu Kullanmak

Pip ön tanımlı olarak pypi repolarından paketleri almakta. Bunun yerine öncelikle bizim repomuza
bakmasını söylememiz gerekiyor. Bunun için `~/.config/pip/pip.conf` dosyasını açın ve içerisine aşağıdaki satırları yazın.

```ini
[global]
index-url = https://devops:devops@pypi.sirketismi.com/devops/pypi/+simple
```

Sonrasında bir virtual environment oluşturarak `pip install <paketismi>` komutunu çalıştırın ve PyPI
indexinin düzgün çalıştığından emin olun. Burada öncesinde gönderdiğiniz ve normal PyPI repolarında
olmayan şirket içerisindeki bir paketi deneyebilirsiniz.

### Uv ile PyPI Sunucusunu Kullanmak

Uv ile kullanırken ortam değişkeninin ayarlanması gerekiyor. Aşağıdaki ortam değişkenini
kullandığınız kabuğa girin ve sonrasında `uv pip install ...` komutunu çalıştırın.

```sh
set -x UV_DEFAULT_INDEX "https://pypi.sirketismi.com/devops/pypi/+simple"
```
