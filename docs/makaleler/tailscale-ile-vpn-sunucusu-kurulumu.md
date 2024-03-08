---
title: Tailscale ile VPN Sunucusu Kurulumu
description: Tailscale ile kendi VPN sunucunuzu nasıl kurarsınız.
---

[VPN][vpn]'in ne demek olduğunu artık hepimiz çok iyi biliyoruz, bu yüzden açıklamayı es geçip
direkt olarak nasıl kendimize özel VPN sunucusu kurabiliriz konusuna eğileceğim.

[Tailscale][tailscale] VPN kurulumunu kolaylaştırıcı, tercih ettiğim bir VPN yazılımı. Kişisel
kullanım için ücretsiz ve birkaç komut ile kurulumu gerçekleştirebiliyoruz. Kurulum kısmında zaman
alan kısım sunucu kiralamak ve basit adımlarını takip etmek. Biz bu basit adımları `Ubuntu 22.04`
üzerinde gerçekleştireceğiz ve makalenin sonunda bütün trafiğimizi Tailscale aracılığı ile bu makine
üzerinden geçireceğiz.

Bu makale giriş seviyesinde bir makale değil ve öncesinde bir sanal sunucu kiralamış, SSH bağlantısı
yapmış kişilere hitab ediyor. Eğer daha önce bunları yapmadıysanız, öncelikli olarak bir sanal
sunucu kiralamanız ve SSH ile erişebilmeniz gerekmekte. Çok zor bir şey değil, internet üzerinde
nasıl sanal sunucu açılır belgeleri mevcut. Bunları takip ederek siz de sanal sunucu açabilirsiniz.

## Ubuntu Kurulumu

Elinizde bir makine yoksa öncelikle bunu edinmeniz gerekmekte. Ben Amazon'un 1 senelik ücretsiz
verdiği krediyi kullanarak EC2 üzerinde `t4g.small` tipinde minik bir makine oluşturdum. Bu makine
`2 CPU, 2 GB RAM, 25 GB disk` ve `5Gbit`'e kadar network'e sahip. VPN için oldukça yeterli. Sizin de
dilediğiniz bir platformda küçük bir sanal makine edinmeniz gerekmekte. [Hetzner][hetzner] ve
[DigitalOcean][do]'ı kullanım kolaylığı ve ucuzluk olarak tercih edebilirsiniz.

Makalenin devamına geçmeden önce makinenin açılmış ve SSH bağlantısının yapılmış olduğundan emin
olun.

## Ubuntu Güncellemesi

Yeni bir kurulum yaptıktan sonra ilk işimizin güncelleme olması iyi bir pratik. SSH bağlantısı
yaptıktan sonra güncelleme komutlarını çalıştırmayı hatırlayalım:

```sh
sudo apt-get update
sudo apt-get upgrade -y
```

!!! note "Terminal Ayarları"
    Bu makalede terminal üzerinde herhangi bir ayar yapmayacağız ve ön tanımlı terminali
    kullanacağız. Ancak kişisel tercih olarak sunucu yönetirken de `fish` kullanmayı tercih
    ediyorum. Bu açıdan terminal çıktıları farklılık gösterebilir. İlginizi çekerse
    [Terminali güzelleştirelim](../linux/terminali-guzellestirelim.md){:target="_blank"}
    makalesine göz atabilirsiniz.

## Tailscale Kurulumu

### Kullanıcı Hesabı

Tailscale [hızlı kurulum belgesinde][install]{:target="_blank"} belirtildiği gibi öncelikli olarak
bir [kullanıcı hesabı][login]{:target="_blank"} oluşturmanız gerekmekte. Bu kullanıcı hesabı
Tailscale ile ilgili yapacağınız tüm işlemlerde kullanılacak. Bu açıdan güçlü bir parola seçmenizi
ve 2 aşamalı doğrulamayı kullanmanızı öneririm.

### Tailscale İndirme

Linux için terminalinize aşağıdaki komutu yazmanız yeterli:

```sh
curl -fsSL https://tailscale.com/install.sh | sh
```

Bu komut sizin bir şey yapmanıza gerek kalmadan Tailscale Ubuntu reposunu anahtarları ile birlikte
ekleyecek ve `apt-get` ile tailscale yükleyecek. Manuel olarak bunları yapmamak için halihazırda
Tailscale'in sunduğu bu scripti kullanıyoruz.
Scriptin kaynak kodlarına [bu adresten][source]{:target="_blank"} ve
Tailscale'in indirme sayfasına [bu adresten][download]{:target="_blank"} erişebilirsiniz.

Kurulumu yaptıktan sonra aşağıdaki mesajla karşılaşacaksınız:

```plain
Installation complete! Log in to start using Tailscale by running:

tailscale up
```

### Paket Yönlendirme Ayarları

Bu cihaz aldığı paketi yönlendireceği için bu ayarı Linux kernelinde açmamız gerekmekte. Bunun için
aşağıdaki komutları girin:

```sh
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
```

### Tailscale Kullanımı

Kurulum sonrası verilen komut ile Tailscale başlayacaktır ancak burada bu sanal makineyi çıkış
makinesi olarak kullanmak için ekstra bir parametre gerekiyor. Bu yüzden Tailscale'i
`--advertise-exit-node` parametresi ile başlatmamız gerekli. Aşağıdaki komutu girerek VPN sunucumuzu
başlatabiliriz:

```sh
sudo tailscale up --advertise-exit-node
```

Daha önce giriş yapmadığımız için bize giriş yapmamız için bir link verecektir.

```plain
ubuntu@vpn:~$ sudo tailscale up --advertise-exit-node

To authenticate, visit:

 https://login.tailscale.com/a/02a13d13690d
```

Giriş yaptıktan sonra `Success.` mesajını görmemiz gerekmekte. Bu mesajı gördükten sonra bu cihaz
Tailscale hesabımıza bağlanmış olacak ve `--advertise-exit-node` parametresi verdiğimiz için
bağlayacağımız diğer cihazlar için çıkış görevi görebilecek.

Bu aşamada [Tailscale hesabınıza][admin]{:target="_blank"} girerek makinenin yan tarafında bulunan
üç noktalı menüye tıklayın, `Edit route settings` ayarlarına girin ve aşağıda bulunan
`Use as exit node` kutucuğunu işaretleyin. `--advertise-exit-node` parametresi vermemiz bu makinenin
hemen çıkış makinesi olarak kullanılacağı anlamına gelmiyor. Tailscale arayüzünden seçilmesi
gerekmekte.

Bundan sonra yapmanız gereken tek şey bilgisayarınıza ve telefonunuza Tailscale kurmak. Burada
yaptığımız gibi Tailscale hesabı ile giriş yapıp, kullanıma başlayabilirsiniz.

!!! note "Çıkış Cihazı Ayarı"
    Bu noktada şunu da hatırlatmam gerekir ki telefonda veya bilgisayarda Tailscale kullandığınız
    zaman çıkış cihazı olarak _(exit node)_ VPN sunucusunu elle seçmemiz gerekmekte. Sonrasında bu
    ayar hatırlanacak ve bir sonraki bağlanmanızda otomatik olarak bu kullanılacak. Tailscale
    bağlantısı yaptıktan sonra IP adresi değişmiyorsa uygulamanın çıkış cihazı kısmını kontrol edin.

### IP Adresleri ve Sertifikalar

Tailscale kullanımının bana sorarsanız en güzel yanı bu. VPN sunucumuzun IP adresleri ve
sertifiklaları ile uğraşmıyoruz. Sadece Tailscale hesabı ile bunları yönetiyoruz ve bizim
hesaplarımıza cihazlar dahil oluyor. Esasında Tailscale VPN'in ötesinde yazılım tabanlı bir ağ
sunuyor. Burada hangi cihazın birbiri ile nasıl haberleşebileceğini de belirleyebiliyoruz ancak bu yazının konusu değil. Şimdilik sadece bir cihazı çıkış cihazı olarak kullanıyoruz.

### IP Adresim Ne

[http://ifconfig.me][ifconfig]{:target="_blank"} adresini ziyaret ederek IP adresinizi
öğrenebilirsiniz. Her şey doğru çalışıyorsa IP adresiniz VPN sunucusunun adresi olarak görünmesi
gerekiyor.

## Sonuç

Tailscale yeni nesil bir yazılım tabanlı ağ hizmeti. Birçok özelliği ile birlikte biz sadece çıkış
cihazı özelliğini kullanarak VPN sunucusu elde ettik. Sadece Tailscale hesabı ile herhangi bir
cihazı buna dahil ederek kullanabilmek büyük bir kolaylık sağlıyor.

Tailscale'in ACL, DNS, SSH, Funnel gibi diğer özellikleri için [kendi belgelerine][install] göz
atabilirsiniz.

[vpn]:          https://en.wikipedia.org/wiki/Virtual_private_network
[tailscale]:    https://tailscale.com
[hetzner]:      https://www.hetzner.com/cloud/
[do]:           http://digitalocean.com
[install]:      https://tailscale.com/kb/1017/install
[login]:        https://login.tailscale.com/start
[source]:       https://github.com/tailscale/tailscale/blob/main/scripts/installer.sh
[download]:     https://tailscale.com/download/linux/ubuntu-2204
[ifconfig]:     https://ifconfig.me
[admin]:        https://login.tailscale.com/admin/machines
