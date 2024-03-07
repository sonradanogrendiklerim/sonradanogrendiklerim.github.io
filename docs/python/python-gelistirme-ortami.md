---
title: VSCode ve Python Geliştirme Ortamı
description: Python ile daha kolay geliştirme nasıl yapılır.
date: 2024-03-06
---

##  Giriş

Önceki bölümde kodlarımızı normal bir metin editörü ile açtık. Lakin Ubuntu ile gelen metin editörü
bize çok fazla bir özellik sunmuyor. Bunun yerine Python yazmak için VSCode iyi bir tercih. En
azından kişisel olarak bu şekilde tercih ediyorum.

Bu bölümde VSCode ile en çok kullanılan özellikleri, Python sanal ortamı nasıl kullanacağımızı ve
VSCode'un bize sunduğu diğer özellikleri inceleyeceğiz.

## VSCode Kurulumu

Burada sadece bir `.deb` uzantılı dosya indirip `apt` komutu kullanarak kuracağız. Öncelikle
[VSCode indirme sayfasına][download]{:target="_blank"} gidip Ubuntu için `.deb` paketini indirin.
Sonrasında indirdiğiniz dizine konsol aracılığıyla girip aşağıdaki komutu çalıştırın:

```sh
cd <indirmedizini>

sudo apt install ./<dosyaismi>.deb
```

Burada `dosyaismi.deb` indirdiğiniz dosyanın ismi olmalı. Kurulum tamamlandıktan sonra önceki
bölümde gördüğümüz `ilkadim.py` ve `factorial.py` dosyalarını VSCode ile açabilirsiniz.

## VSCode'a Giriş

### Renk Teması

İlk kurulum ayarlarını yaptıktan sonra öntanımlı renk teması yerine başka bir renk teması seçmeyi
tercih edebilirsiniz. Bu ekrana saatlerce bakacağımız için öncelikli olarak size uygun temayı
bulmanızı tavsiye ederim. Ben göz yormaması açısından [Solarized Dark][solarized] temasını
kullanıyorum. Bunu sol tarafta tepeden 5. sırada bulunan kutucuk ikonuna _(Extensions)_ tıklayarak
yükleyebilirsiniz. Yükledikten sonra VSCode ayarlarından bunu seçmelisiniz.

### Eklentiler

Eklentiler _(extensions)_ bölümü VSCode ayarları yaparken sık kullanacağımız bir bölüm olacak.
Birçok iş için eklenti halihazırda yazılmış durumda ve öncelikle buraya bakacağız. Yazının konusu
geliştirme ortamını tanıtmak olduğundan ilerleyen kısımda Python kodlarımızı daha iyi yazmamız için
başka eklentileri de yükleyeceğiz. Şimdilik sadece renk temasını yüklemeniz yeterli.

## VSCode Kısayolları

Kısayollar hayatımızı kolaylaştırıyor. Sık olarak yaptığımız işlemleri kısayollar ile yapmak bize
zaman kazandıracak ve saatlerce bunu yaptığımızı düşünürsek 1 saniyelik bir hızlanma bile toplamda
bize saatler kazandırabiliyor. Bu açıdan benim bildiğim ve kullandığım kısayolları burada tanıtmak
isterim. VSCode'un bütün kısayollarını bildiğimi veya kullandığımı söyleyemem ancak bunlar bana
yetiyor.

### Dosyalar Arasında Gezinme

En sık kullanılan kısayol diyebiliriz. `CTRL + p` tuşu ile proje içerisinde herhangi bir dosya
ismini arayabilir ve `enter` ile açabilirsiniz. Burada [fuzzy search][fuzzy]{:target="_blank"} denen
bir yöntem kullanılıyor. Dosyanın ismini hatırlamak ya da tam yazmak zorunda değilsiniz, başından
veya sonundan herhangi bir kısmını yazmanız yeterli. VSCode bu noktada güzel bir biçimde tamamlama
sağlıyor.

Örneğin bu dosyanın ismi `python-gelistirme-ortami.md` ve bu dosyayı ararken sadece `ortam` yazmam
ve `enter` tuşuna basmam yetiyor.

### Projenin Tamamında Arama Yapma

`CTRL + Shift + f`. Bu kısayol ile proje içerisindeki bütün dosyalarda arama yapabilirsiniz. Sol
tarafta bu arama kısmı kalacağı için tekrar geriye dönmek isteyeceksinizdir. Bunu da bir sonraki
kısayol ile başarabilirsiniz. Ben arama yaptıktan sonra her daim proje dosyalarını görmek
istediğimden bir sonraki kısayol ile beraber kullanıyorum.

### Proje Dosyalarını Görme

`CTRL + Shift + e`. Arama yaptıktan sonra kullandığım kısayol. En baştaki proje görünüşüne geri
dönüyoruz.

### Dosya İçerisindeki Tanımlarda Arama

`CTRL + Shift + o` (Ordunun O'su). Bir dosya üzerinde çalışırken bunun içerisindeki tanımlara kolay
erişmenizi ve arama yapmanızı sağlar. Python veya markdown ile belge yazarken dosyanın içerisindeki
tanımlı kısımlara atlamanızı kolaylaştırıyor. Bunu Python yazarken fonksiyonlara, değişkenlere ve
sınıflara ulaşmak için, Markdown yazarken başlıklara ulaşmak için kullanabilirsiniz.

`ilkadim.py` örneğine gidip bu kombinasyonu kullandığınızda daha net bir şekilde anlayabilirsiniz.
Dosya ismi aramasında geçerli olduğu gibi burada da arama metnini tam yazmak zorunda değilsiniz,
[fuzzy search][fuzzy] VSCode'un hemen hemen her yerinde geçerli ve işimizi kolaylaştırıyor.

### VSCode Komutlarına Erişme

`CTRL + Shift + p`. Bu kısayol VSCode'un bütün komutlarına erişmenizi sağlıyor. Bütün ayarlardan tutun, Python ortamını seçmeye kadar birçok komut mevcut.

### VSCode İçerisindeki Konsol

`CTRL + j`. Pencereler arasında geçmeden VSCode ile konsol kullanılabiliyor. Bu konsolu açmaya
yarar. Ben bu konsolu kod yazdığım zaman kapatıp, ihtiyacım olduğunda açarak kullanıyorum.
Böylelikle geçiş yaparken dikkatim dağılmıyor.

## Python Sanal Ortamı

Konsolu açtığınızda Python sanal ortamı aktive olarak gelmeyecek. VSCode bunun için proje dizininde
`venv` dizini varsa kullanımı sağlayabiliyor. Otomatik olarak kullanım sağlanmıyorsa yine
kısayollari le bunu başarabiliyoruz.

VSCode komutlarına erişirken kullandığımız `CTRL + Shift + p` kombinasyonu ile `pyselect` yazarak buna erişebiliriz. Devamında size liste sunacaktır. Bu listeden `venv` seçin ve konsolu tekrar başlatın. Her şey yolunda giderse konsolda sanal ortamın seçili olduğunu göreceksiniz.

[download]:     https://code.visualstudio.com/download
[solarized]:    https://marketplace.visualstudio.com/items?itemName=ginfuru.ginfuru-better-solarized-dark-theme
[fuzzy]: https://en.wikipedia.org/wiki/Approximate_string_matching
