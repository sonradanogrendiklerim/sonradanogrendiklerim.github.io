---
title: Programlama Dili Nedir
description: Programlama dili nedir, neden ve nasıl ortaya çıktı.
---

## Giriş

Adı aslında üzerinde; herhangi bir programlama dilini kelimelerin ifade ettiği şekilde anlayacak
olursak bu bir `dil`. Türkçenin nasıl gramer kuralları varsa, programlama dillerinin de gramer
kuralları var ve gramerini, kelimelerini doğru kullandığımız ölçüde kendimizi ifade edebiliyoruz,
yani program yazıyoruz.

Programlama dilleri dedik çünkü kullanabileceğimiz tek bir programlama dili yok, etrafta binlerce
programlama dili mevcut. Biz burada sadece [Python][python]{:target="_blank"} ile ilgileneceğiz
ancak yaklaşımımız ezberlenmiş şekilde değişken tanımları, fonksiyonlar yerine tarihsel olacak. Bir konuyu öğrenirken arka planında neler olmuş, neden bu şekilde yapıyoruz soruları bana göre öğrenmeyi kolaylaştırıcı sorular.

Yazının sonunda bilgisayar nasıl çalışır, nasıl programlayabiliriz, programlama dilleri neden ve
nasıl ortaya çıktı konuları hakkında fikrimiz olacak.

[python]: https://www.python.org

## Bilgisayar Nasıl Çalışır

### İşlemci

İşlemci dediğimiz çok küçük ve güçlü elektronik devre parçası ve sadece 1 ve 0, yani ikilik sistemi
anlıyor. Burada dünyada 1 işlemci ya da işlemci mimarisi olduğu anlaşılmasın, yine programlama
dillerinde olduğu gibi yüzlerce, belki binlerce işlemci ve işlemci mimarisi var. Lakin en çok x86 ve
ARM kullanmaktayız. Telefonlarımızda düşük güçte yüksek performans verebildiği için ARM, sunucularda
veya kişisel bilgisayarlarımızda ise x86 yaygın olarak kullanılmakta. Son zamanlarda ARM mimarisi
sunucu performasına gelmiş olsa da ARM ve x86 karşılaştırması şimdilik konumuz değil.

1 ve 0'lardan oluşan sisteme matematikte ikilik sistem, yani `binary` denmekte. Bu ikilik sistem ile
oluşturduğumuz verilere ise ikiliik veri, ingilizcesi ile `binary data` deniyor. Peki elimizde
sadece 1 ve 0 varsa işlemciye nasıl komutlar göndereceğiz, nasıl toplama, çıkarma gibi matematik
hesabı yaptıracağız? Yaptırmayı bırakalım, işlemci sadece 1 ve 0 algılıyorsa, kendi içerisinde bu
işlemleri nasıl yapabiliyor?

Korkmayın, bütün bu soruların cevabı aslında çok basit. İşlemci o kadar basit bir şekilde çalışıyor
ki yıllar sonra bunu anladığımda gerçekten çok şaşırmıştım.

---

Gelin beraber fikir yürüterek, elimizde sadece 1 ve 0 varken bir `şey`'e nasıl komut verebiliriz
pratiği yapalım. Henüz nasıl çalıştığını bilmiyoruz, ileride bunun üzerine de düşüneceğiz ancak
şimdilik bir toplama işlemini nasıl ifade edebiliriz üzerine düşünelim.

Öncelikle bu kara kutu için toplamda kaç adet 1 ve 0 kullanacağımızı belirlememiz gerekiyor. Bunun için 8 adet 1 ve 0 yeterli gibi görünüyor. Dolayısıyla ifade edeceğimiz her şeyi 8 adet ikilik sayı ile ifade edeceğiz.

Verinin aksine ifade edeceklerimizin sayısı bu kadar değil. Sadece 2 adet ifade edeceğimiz durum
mevcut.

1. Hangi işlemi yapacağımız
2. Bu işlem için kullanacağımız veri

Burada hangi işlem ve kullanacağımız veri miktarı için ne kadar 1 ve 0 ayıracağımız tamamen bize
kalmış durumda. Yine kolaylık olması açısından ilk 2 haneyi işlem, sonraki 6 haneyi veri olmak üzere
8 adet 1 ve 0 kullanacağız. Buna kısaca `bit` diyoruz. Yani ilk 2 bit işlem, sonraki 6 bit veri
olacak bu kara kutuda.

!!! tip "Bit ve Byte"
    Bu yazıda çok kullanmayacağız ancak burada görülmesinde fayda olduğunu düşünüyorum. 8 adet bit
    yan yana geldiğinde buna `byte` denmekte. Kara kutumuz ile ilgili konuşurken her daim bit hesabı
    yapacağız ancak daha büyük verileri nitelendirmek istediğimizde `byte` kullanılmakta. Kilobyte,
    Megabyte gibi standard ünite değerlerine burada dokunabilirdik ancak ana konumuz bu olmadığı için merak edenlere [wikipedia makalesini][siunit]{:target="_blank"} tavsiye ederim.

İkilik sistemi düşünürsek hangi işlemi yapacağımızı ifade ettiğimiz 2 bit ile toplamda 4 adet işlem ifade edebiliyoruz:

```plain
00
01
10
11
```

Veri için elimizde 6 tane bit olduğu için, 2 üzeri 6 _(2^6=64)_ adet durum ifade edebiliyoruz. Bu da
demek oluyor ki onluk tabanda en fazla 64 sayısına kadar toplayabiliriz çünkü fazlasını ifade
edemiyoruz.

```plain
000000
000001
000010
000011
...
111111
```

Bunların hepsini bir araya getirdiğimizde şu şekilde bir tablo ortaya çıkıyor:

```plain
00 000000
|  ------> İşleme ait veri
|--------> İşlem (opcode)
```

Burada işlemimizi ilk 2 bit ile ifade ettik ve bu işlemin alacağı herhangi bir değere 6 bit atadık.
Dikkat ederseniz bunların tamamı hayal ürünü ve bizim ona anlam ifade ettiğimiz kadar anlamlı. Şu an herhangi bir şey ifade etmiyor, anlam yüklemeye başlayabiliriz.

---

- Toplama işlemi için 2 register
- Register'a veri koymak için, yukle
- Toplama işlemi için 1 komut, topla
- Sonucu ilk registera yazılıyor.

[siunit]: https://en.wikipedia.org/wiki/Byte#Multiple-byte_units

### RAM

### Disk

## Notlar

- Dil nedir
- Bilgisayar tarihçesi, nelerden oluşur
- İkilik sistem ve assembly
- Nasıl programlıyoruz. CPU RAM Disk ilişkisi
- Python programı, REPL, bash/fish farksız
- Program çalıştıran program
