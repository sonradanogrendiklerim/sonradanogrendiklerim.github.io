---
title: Terminal Komutu Nasıl Çalışır
description: Terminalimize yazdığımız komutların nasıl çalıştırıldığına giriş.
date: 2024-03-08
---

Terminalimizi güzelleştirdik, `ls` komutunu kullandık ve en çok kullandığımız komutlar için kısayol,
yani `alias` tanımladık. Ancak hala bu `ls` komutunun nasıl ve ne şekilde çalıştırıldığını
bilmiyoruz. Bu bölümde herhangi bir komutun nerede barındığına ve nasıl çalıştırıldığına
değineceğiz.

## Terminal Komutu Nerede?

Fish ve bash gibi yazılımların birer metin arayüzü olduğunu tekrar hatırlatalım. Bizim büyük bir
bilgisayar ile etkileşmemizi sağlıyorlar ve modern dünyada yaşadığımız için biz bunu hala
[emüle ediyoruz](../ubuntu/terminal.md#emulator){:target="_blank"}. Burada sormamız gereken soru bu komutlar nerede ve nasıl bulunup çalıştırıldıkları.

Bunun cevabı sabit disk. `ls` gibi komutlar sabit disk üzerinde duruyor ve öncesinde gördüğümüz
gibi bir çıktı veriyorlar.
Bu `ls` uygulamasının, _(şimdilik komutunun demeyelim, metin tabanlı uygulama diyelim ki aklımıza daha net otursun)_, nerede olduğunu `which` uygulaması ile görebiliyoruz.

```sh
❯ which ls
/usr/bin/ls
```

Bu da demek oluyor ki `ls` yazdığımızda `/usr/bin/ls` çalıştırılıyor. Bu dosya tipinin ne olduğunu
da `file` uygulaması (komutu) ile görebiliyoruz.

```sh
❯ file /usr/bin/ls
/usr/bin/ls: ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), ...
                                    ↑
                                    |
```

Buradaki çıktı sizin sisteminizde farklılık gösterecektir ancak önemli olan burada `executable`
satırını görmek. Yani bu bir uygulama. Terminalimize `ls` yazdığımızda `/usr/bin/ls` çalıştırılıyor.
Peki terminalimiz bunu nasıl buluyor?

Her seferinde `which` çalıştırıp, uygulamanın nerede olduğunu bulup, ona göre hareket edebilir ancak
bu sefer de `which` komutunu nasıl bulacağı sorusu ile karşı karşıyayız. Tavuk - yumurta problemi
yani. Demek ki elimizde başka bir yöntem olması gerekli.

Bunun için terminalimiz ortam değişkenleri kullanıyor.

## Ortam Değişkenleri

Başı dolar işareti ($) ile başlayan değişkenler. Terminal içerisinde `echo` komutu ile görülebilir. Örneğin ev dizininiz öntanımlı olarak `$HOME` değişkenine atanıyor.

```sh
echo $HOME
```

Atanmış bütün ortam değişkenlerini `env` komutu ile görüyoruz. Aşağıda en sık kullanılan ve önem arz
edenleri listeledim. Sizde daha fazla çıktı görülecektir.

```plain
❯ env
...
...
USER=eren
PWD=/home/eren.linux
LANG=C.UTF-8
SHELL=/usr/bin/fish
HOME=/home/eren.linux
TERM=xterm-256color
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
  |
  |--> sihir burada
```

Terminalin bir uygulamayı bulurken yaptığı şey çok basit. `$PATH` içerisinde `:` ile ayrılmış
dizinlere __sırası ile__, teker teker bakıyor ve bulmaya çalışıyor. Bulduğu ilk uygulamayı
çalıştırıyor. Bu da demek oluyor ki `/usr/local/__sbin__` ve `/usr/local/__bin__` içerisinde aynı
isimde uygulama varsa öncelikle `/usr/local/sbin` içerisindeki çalıştırılacak.

Burada `absolute path` ve `relative path` konusuna da değinmemiz gerekli. Terminalimiz bir komut
yazdığımızda her daim `$PATH` değişkenine bakarak karar veriyor. Bu durumda ikinci sırada yer alan
uygulamayı çalıştırmak için `tam path` vermemiz, yani `/usr/local/sbin/uygulamaismi` şeklinde
kullanmamız lazım. `Relative path` ise o an bulunduğumuz dizine göre, başında `/` olmadan
verdiğimiz path anlamına geliyor. Konu hakkında daha detaylı bilgi için
[Redhat belgesine][path]{:target="_blank"} göz atabilirsiniz.

!!! note "cd komutu üzerine"
    `cd` komutu disk üzerinde değil, terminal emülatörünün kendi içerisinde olan bir komut ve o anki
    çalışma dizinini değiştiriyor ($PWD). Bunun için ayrı bir uygulamaya gerek yok ve shell kendi
    içerisinde bunu sağlamakta. Bu yüzden `which` ile `cd` komutunu bulamıyoruz çünkü disk üzerinde
    değil, öntanımlı bir komut.

## Uygulamayı Bulduk, Sonra?

Özetle, shell birtakım hazırlıklar yaptıktan sonra Linux kerneline bu uygulamayı çalıştır şeklinde
bir [sistem çağrısı][syscall] _(syscall)_ gönderiyor _([execve][execve]{:target="_blank"})_. Linux
kerneli uygulamayı diskten okuyup RAM'e yüklüyor ve sonrasında RAM'de nerede yer alıyorsa oradan
çalıştırmaya devam ediyor. Uygulama işini bitirdikten ve çıktıktan sonra tekrar shell'e dönüyor.

Tabii ki bu çok basitleştirilmiş bir anlatım oldu. Bunun içerisinde kernelin yaptığı
[ELF][elf]{:target="_blank"} parsing, [dinamik kütüphaneleri][dynamic]{:target="_blank"} bulma gibi
şeyler de var ama bu 3. sınıf işletim sistemleri konusu. Şimdilik bu kadarının büyük resmi görmek
açısından yeterli olduğunu düşünüyorum.

[path]:     https://www.redhat.com/sysadmin/linux-path-absolute-relative
[syscall]:  https://en.wikipedia.org/wiki/System_call
[execve]:   https://en.wikipedia.org/wiki/Exec_(system_call)
[elf]:      https://en.wikipedia.org/wiki/Executable_and_Linkable_Format
[dynamic]:  https://en.wikipedia.org/wiki/Dynamic_linker
