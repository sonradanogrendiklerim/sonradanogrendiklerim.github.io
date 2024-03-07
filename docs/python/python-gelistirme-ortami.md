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

Burada `dosyaismi.deb` indirdiğiniz dosyanın ismi olmalı.

## VSCode'a Giriş

[download]: https://code.visualstudio.com/download
