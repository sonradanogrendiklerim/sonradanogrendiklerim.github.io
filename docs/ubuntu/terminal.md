---
title: Linux Terminali
description: Terminal nasıl ortaya çıktı, tarihçesi ve bugünü.
---

## Emülatör

Terminali anlamak için aslında [emülator][emulator]{:target="_blank"} kelimesine biraz aşina olmamız
gerekiyor. Sektör genelinde kısaltılmış olarak `terminal` dense de aslında burada kastettiğimiz
`terminal emülatörü`.

Emülatöre kelime anlamıyla `bir [şey] gibi davranmak` diyebiliriz. Bunu en iyi şekilde anlamak için
eskiden(?) televizyona bağlayarak oynadığımız `Mario`, `Mortal Combat` gibi oyunları elimizdeki yeni
bilgisayarlar ile nasıl oynayabiliriz üzerine düşünmemiz gerekiyor. Bu oyunların çalıştığı,
televizyona bağladığımız cihazlar da birer bilgisayardı ve kendilerine ait apayrı teknolojileri
vardı.

Dışarıdan baktığımızda aslında ortaya bilgisayar içinde bilgisayar fikri ortaya çıkıyor. Bu oyunları
oynamak için [x86][x86] veya başka bir mimariye sahip bilgisayarlarımızda,
[NES][nes]{:target="_blank"} veya [Atari][atari]{:target="_blank"} mimarisini emüle etmemiz
gerekmekte. Yani eksiğiyle ve fazlasıyla tam anlamıyla onun gibi davranmasını sağlamamız gerekiyor
ki bu oyunları *(programları)* çalıştırabilelim.

Bunu yapabilmek için bir emülatöre ihtiyacımız var. Bu emülatörü de Firefox veya Microsoft Word gibi
bilgisayarımızda çalışan herhangi bir program olarak düşünebiliriz. Sadece eski oyunları çalıştırmak
için oluşturulmuş, özel olarak tasarlanmış, ilgili mimariyi çok iyi kavramış ve nasıl çalıştığını
bilerek ona göre davranan bir uygulamadan, __yazılımsal bir bilgisayardan__, fazlası değil.
Günümüzde [DOSBox][dosbox]{:target="_blank"} ve [Wine][wine]{:target="_blank"} bunlara örnek olarak
verilebilir.

[emulator]: https://simple.wikipedia.org/wiki/Emulator
[nes]:      https://simple.wikipedia.org/wiki/Nintendo_Entertainment_System
[atari]:    https://en.wikipedia.org/wiki/Atari_2600
[x86]:      https://simple.wikipedia.org/wiki/X86
[dosbox]:   https://en.wikipedia.org/wiki/DOSBox
[wine]:     https://simple.wikipedia.org/wiki/Wine_(software)

## Terminal

*Not: Burada yazdıklarım tarihsel olarak gerçeği tam olarak yansıtmayabilir. Genel bağlamda durumun*
*nasıl olduğunu anlatmaya çalıştım. Bilgisayar tarihçileri yanlış yaptığım bir nokta olursa lütfen*
*düzeltsinler.*

Bilgisayarların tarihçesine baktığımız zaman tonlarca ağırlıkta, günümüzle kıyasladığımızda çok
düşük işlem performansı görüyoruz. Bu bilgisayarların şu anda olduğu gibi birden fazla kullanıcı ile
kullanılabildiğini düşünmeyin. Tek bir iş yapıyorlar ve tek bir kullanıcıları var. Bu
bilgisayarlarla komut gönderip sonuç almanın yolu ise `terminaller`.

<!-- markdownlint-disable-next-line -->
<figure markdown="span">
  ![VT100 Terminal](https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/DEC_VT100_terminal.jpg/811px-DEC_VT100_terminal.jpg)
  <figcaption>VT100 Terminal</figcaption>
</figure>

Düşünün ki aşağıdaki komutu bilgisayara gönderiyorsunuz:

```py
2 + 2
```

ve size cevap olarak tek satırda `4` cevabını dönüyor. İşin kötü yanı ise bu cevapların satır satır
size dönüyor olması. Bu bilgisayarı programlayacak olsanız ekrana basacağınız yazıları dikkatli
seçiyor olurdunuz çünkü bir kere ekrana basıldıktan sonra programatik olarak geri dönüp bunu
silmenin __standard__ bir yolu yoktu. En azından [ANSI][ansi]{:target="_blank"} özel (kaçış)
karakterlerini ilk destekleyen terminallerden biri olan [VT100][vt100]{:target="_blank"} gelene
kadar durum bu şekildeydi. VT100 birçok özellik ile geldi. Standard haline gelen ANSI kodlarını
desteklemesi birçok bilgisayar ile uyumlu çalışmasını sağladı ve milyonlarca sattı.

Yani aslında terminal dediğimiz şey fiziksel bir cihaz ve bilgisayar ile kablo ile bağlı şekilde
işini yapmakta.

[ansi]:     https://en.wikipedia.org/wiki/ANSI_escape_code
[vt100]:    https://en.wikipedia.org/wiki/VT100

## Linux Terminal Emülatörü

Linux üzerinde çalıştırabileceğiniz yüzlerce terminal uygulaması var. Bu terminal uygulamaları
yukarıda açıklandığı gibi çeşitli karakterler kullanıyorlar. [ANSI][ansi] kaçış karakterleri ile
ekrandaki yazı renklerini, büyüklüklerini, boyutlarını değiştirebiliyorlar; yeni satıra
geçebiliyorlar, bir önceki satıra dönüp üzerine yazabiliyorlar ve yazının arkaplanını farklı, ön
planını farklı yapabiliyorlar.

Dolayısıyla bu uygulamaların çıktılarını ekranda gösterecek olan `terminal` uygulamasının da belli
bir formatı desteklemesi, `emüle` etmesi gerekmekte. Artık VT100 fiziksel olarak kullanılmadığı
için, zamanında oluşturulmuş standardları emüle etmemiz gerekmekte ki terminal ekranımızda düzgün
çıktı görebilelim. VT100 o kadar yaygınlaştı ki hala bunu ve diğer terminalleri emüle ederek
kullanmaktayız. `Emülatör`, `Terminal` ve `Terminal Emülatörü` arasındaki ilişki bundan ibaret.

## Emülatörümüzü Deneyelim

Terminal uygulamasını açın ve ilk komutunuzu girin:

```sh
echo -e " DUZ YAZI"
```

Bu komut parametre olarak ne alıyorsa aynısını size verecektir. Her ne kadar kısa sürse de bunu uzun
süren bir komut olarak düşünüp, dakikalarca bekleyip, bittiğinde terminalinizde bir şeyler görüyor
olarak hayal edebilirsiniz. Şimdiye kadar öğrendiklerimizi deneyecek olursak ekrana kırmızı, kalın,
yeşil vb. yazı yazmak ve emülatörümüzü test etmek için `echo` komutu uygun bir komutmuş gibi
duruyor.

```sh
echo -e "\e[1;31m KIRMIZI YAZI \e[0m"
```

Bu komut ekrana kırmızı bir yazı basacaktır. Unutmayın. Terminal emülatörü kullanıyoruz.
Bilgisayarımıza bir komut gönderdik, bu komutun cevabı hiç değişmeden bize geldi, gelen bu cevap da
terminal emülatörü tarafından yorumlandı ve ekranda göründü.

Burada yapılan şey basit. ANSI kaçış kodları içerisinde `ben şimdi başlıyorum, buradan sonrasıyle
özel olarak ilgilen` karakterleri mevcut ve işini bitirdiği zaman `ben tamamım, artık normale
döndük` diyor. Burada renkler için bu kaçış kodunun başlangıcı `\033[95m` ve bitişi `\033[0m`
karakterleri ile ifade ediliyor. Terminal emülatörümüz bu kodları alıyor, yorumluyor ve ekranda
düzgün biçimde gösteriyor. Daha fazlası için [StackOverflow'da yazılmış detaylı cevaba][stackoverflow]{:target="_blank"} ulaşabilirsiniz.

[stackoverflow]: https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences

## Terminal ile İlişkiniz

Hayır, o ilişki değil. Ubuntu arayüzünde gördüğünüz ve yapabildiğiniz her şeyi *(dosya silme,*
*oluşturma, değiştirme, ve daha fazlasını)* terminal ile yapabilirsiniz. Hatırlayacağınız üzere
bilgisayar ile ilişkinin temeli terminale dayanıyor ve biz de modern dünya olarak bunu emüle edip
kullanıyoruz.

Bunun gibi komutları yine temel linux komutları anahtar kelimeleri ile öğrenebilirsiniz. Bu
komutları öğrenmenizi, test etmenizi, sonucunda ne olduğunu öğrenmenizi ve grafik arayüzünden
bağımsız olarak kendinizi sadece terminal kullanmaya yönlendirmenizi tavsiye ederim.

Kod geliştirme aşamasında neredeyse tamamiyle terminal kullanacağınız için bu yetkinliğe sahip olmak
size artı bir değer olarak geri dönecektir.

## İlgilisine Dizi Önerisi

Bilgisayarların mesai saatleri sonrası kapatılıp sonrasında tekrar açılması ile başlayan
ve paylaşımlı bilgisayarlardan nasıl para kazanılabileceği ile devam eden [Halt and Catch Fire][halt-catch]{:target="_blank"} dizisini de ilgililere öneririm.

[halt-catch]: https://www.imdb.com/title/tt2543312/
