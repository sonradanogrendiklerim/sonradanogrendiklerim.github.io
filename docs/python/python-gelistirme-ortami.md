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

Burada sadece bir `.deb` uzantılı dosya indirip `apt` komutu kullanarak kuracağız. Öncelikle [VSCode indirme sayfasına][download]{:target="_blank"} gidip Ubuntu için `.deb` paketini indirin.
Sonrasında indirdiğiniz dizine konsol aracılığıyla girip aşağıdaki komutu çalıştırın:

```sh
cd <indirmedizini>

sudo apt install ./<dosyaismi>.deb
```

Burada `dosyaismi.deb` indirdiğiniz dosyanın ismi olmalı. Kurulum tamamlandıktan sonra önceki bölümde gördüğümüz `ilkadim.py` ve `factorial.py` dosyalarını VSCode ile açabilirsiniz.

## VSCode'a Giriş

İlk kurulum ayarlarını yaptıktan sonra renk teması seçmeyi tercih edebilirsiniz. Bu ekrana saatlerce
bakacağımız için öncelikli olarak size uygun temayı bulmanızı tavsiye ederim. Ben göz yormaması
açısından [Solarized Dark][solarized] temasını kullanıyorum. Bunu sol tarafta tepeden 5. sırada
bulunan kutucuk ikonuna _(Extensions)_ tıklayarak yükleyebilirsiniz. Yükledikten sonra VSCode
ayarlarından bunu seçin.

Extensions bölümü VSCode ayarları yaparken sık kullanacağımız bir bölüm olacak. Birçok iş için
eklenti halihazırda yazılmış durumda ve öncelikle buraya bakacağız. Yazının konusu geliştirme
ortamını tanıtmak olduğundan ilerleyen kısımda Python kodlarımızı daha iyi yazmamız için başka
eklentileri de yükleyeceğiz.

[download]:     https://code.visualstudio.com/download
[solarized]:    https://marketplace.visualstudio.com/items?itemName=ginfuru.ginfuru-better-solarized-dark-theme
