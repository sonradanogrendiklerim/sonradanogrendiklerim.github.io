---
title: Fish Terminal Eklentileri
description: Terminal kullanırken işimizi kolaylaştıracak eklentiler.
date: 2024-03-24
---

Terminalimizi [güzelleştirdik][terminal-guzellestirdik] ve Fish shell kullanmaya başladık. Bundan
sonrasında bence terminalin olmazsa olmazsı birkaç eklentiye değinmek istiyorum. Bu eklentiler
terminalimizi daha hızlı kullanmamızı sağlıyor ve bize zaman kazandırıyor.

## Fisher: Plugin Yöneticisi

Fish içerisine plugin yüklerken kullandığımız bir [yönetim uygulaması][fisher]{:target="_blank"}. Bu
plugin yöneticisi destekleyen pluginleri kolay bir şekilde kurmamızı sağlıyor ve güncellemeleri
daha rahat yapmamıza olanak tanıyor. Öncelikle Fisher uygulamasını aşağıdaki komut ile kuralım:

```sh
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

Kurulduktan sonra `fisher` komutu aktif hale gelecektir. Var olan eklentileri listelemek için
`fisher list` komutunu çalıştırın. Eklenti başarılı bir şekilde yüklendiyse bu komut
`jorgebucaran/fisher` çıktısını verecektir.

## Fzf: Terminal Geçmişi Araması

Her yazdığımız terminal komutu bir geçmiş dosyasına sonradan kullanılmak üzere kaydediliyor. Bunu ok
tuşları ile önceki ve sonraki şeklinde görebiliyoruz ancak terminal geçmişimiz fazlalaştığında
bunların arasından istediğimiz komutu bulmak zorlaşayabiliyor. [Fzf][fzf]{:target="_blank"} bu
noktada bize yardımcı oluyor. [Fuzzy searching][fuzzy]{:target="_blank"} denilen bir method
ile terminal geçmişini arayarak çok hızlı bir şekilde aradığınız komutu bulmanıza olanak sağlayan
bir eklenti.

Eklentiyi aşağıdaki komut ile kurduktan sonra `CTRL + R` tuş kombinasyonları ile arama yapmaya
başlayabilirsiniz:

```sh
fisher install PatrickF1/fzf.fish
```

Sadece terminal geçmişi değil, git loglarında ve dosyalarda benzer şekilde arama yapabilirsiniz.
İlgili tuş kombinasyonları fzf'nin sayfasında mevcut.

## Z: Dizinler Arasında Kolay Geçiş

Muhtemelen terminalde kullandığımız en sık komutlardan bir tanesi `cd` komutudur. Bu komut ile
dizinleri değiştirirken sürekli aynı dizin isimlerini yazmak zor olabiliyor. `Z` eklentisi dizinler
arası geçişi kolaylaştırmak için var.

Bu eklenti giriş yaptığınız dizinleri kaydedip, `z` komutu sonrasında verdiğiniz herhangi bir dizin
ismi ile otomatik tamamlama yapıyor. Bu eklentiyi kurmak için aşağıdaki komutu girin:

```sh
fisher install jethrokuan/z
```

Devamında birkaç cd komutu kullandıktan sonra `z dizinismi` ile otomatik tamamlama yapabilirsiniz.
Burada yine `fuzzy search` kullanılmakta. Yani z kullanırken dizin isminin tamamını girmek zorunda
değilsiniz, sadece bir kısmını girerek `TAB` tuşuna bastığınızda olası dizinleri size gösterecektir.

## Sonuç

Terminal en çok zaman geçirdiğimiz araç ve bunu kullanırken bu tarz eklentiler bize zaman
kazandırmakta. Burada en çok kullandığım eklentileri listelemek istedim. Eklentiler bunlarla sınırlı
değil ve siz de bunların üzerine uygun gördüğünüz eklentileri [bulup][awsm]{:target="_blank"}
kurabilirsiniz.

[terminal-guzellestirdik]: ../linux/terminali-guzellestirelim.md
[fisher]:   https://github.com/jorgebucaran/fisher
[fzf]:      https://github.com/PatrickF1/fzf.fish
[fuzzy]:    https://en.wikipedia.org/wiki/Approximate_string_matching
[awsm]:     https://github.com/jorgebucaran/awsm.fish
