---
title: "Programlama Dili: Neden ve Nasıl"
description: Bilgisayar nasıl çalışır, programlama dili nedir, neden ve nasıl ortaya çıktı.
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

## Programlama Dilleri Nasıl Çalışır

### İşlemci

İşlemci dediğimiz nispeten küçük bir elektronik devre parçası ve sadece 1 ve 0, yani ikilik sistemi
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

Verinin aksine ifade edeceğimiz durum sayısı bu kadar değil. Sadece 2 adet ifade edeceğimiz
durum mevcut.

1. Hangi işlemi yapacağız
2. Bu işlem için hangi veriyi kullanacağız

Burada hangi işlem ve kullanacağımız veri miktarı için ne kadar 1 ve 0 ayıracağımız tamamen bize
kalmış durumda. Yine kolaylık olması açısından ilk 2 haneyi işlem, sonraki 6 haneyi veri olmak üzere
8 adet 1 ve 0 kullanacağız. Burada kullandığımız 1 ve 0'lara kısaca `bit` diyoruz. Yani ilk 2 bit
işlem, sonraki 6 bit veri olacak bu kara kutuda.

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
000000 -> onluk sistemde 0
000001
000010 -> onluk sistemde 3
000011
...
111111 -> onluk sistemde 64
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

Toplama işlemi ile başlayalım demiştik. Kara kutumuza komut gönderirken `00` ile ifade ettiğimiz değer toplama işlemi olsun ve sonrasında 6 bit ile ifade ettiklerimiz üzerine ekleyeceğimiz sayıyı ifade etsin. Yani aşağıdaki komut 7 sayısını toplamayı ifade edecek:

```plain
00 000111
|  |-----> onluk tabanda 7 sayısı
|--------> toplama işlemi
```

Burada dikkat etmemiz gereken nokta hala hayal ürünü bir kara kutu ile çalışıyoruz. Nasıl
toplayacağız, neyi toplayacağız, ne nerede duruyor, sonucu nasıl alacağız gibi sorularla
şimdilik ilgilenmiyoruz. Sadece tek ilgilendiğimiz nokta bu kara kutuyu nasıl yöneteceğimiz ve
bize hayali olarak ne sunduğu.

Kara kutumuza bu komutu gönderdiğimizde bizim için toplama işlemi yapacak. Tebrikler, ilk işlemci
mimarinizi ve programlama dilinizi oluşturdunuz. Sadece 1 adet komut
([opcode][opcode]{:target="_blank"}) kabul ediyor ve gramer olarak ilk 2 bit işlem, sonrasında gelen 6 bit işlem için gereken veri kısmını anlıyor.

[opcode]: https://en.wikipedia.org/wiki/Opcode
[siunit]: https://en.wikipedia.org/wiki/Byte#Multiple-byte_units

### Böyle Programlama Olmaz Olsun

Evet, böyle programlama çok zor ve hataya açık ama ilk bilgisayarlar ortaya çıkmışken programcılar
bu şekilde ikilik halde bilgisayarı programlıyorlardı. Onlar da bunun farkındaydı ve daha kolay
nasıl programlanabilir sorusunun cevabını arıyorlardı. Bu cevap [Grace
Hopper][hopper]{:target="_blank"}'ın ilk [derleyiciyi (compiler)][compiler]
[1951 yılında][firstcompiler] yazması ile geldi ve bu acı son buldu. Gerçi hala JavaScript acısı çekiyoruz ama bu Hopper'ın emeklerini boşa çıkarmıyor :)

### Derleyici

Bir programı alıp başka programa dönüştüren program olarak kısaltabiliriz. Bu tamamen yukarıda
bahsettiğimiz zorluk ve hataya açık olma sebebiyle ortaya çıkmış bir kolaylık. Hopper bu durumun
farkında olarak bunun üzerine düşünmüş ve ilk derleyiciyi yazmış. Kendimiz derleyici yapıyor olsak
ve kendi problemimizi çözüyor olsaydık, artık hayal ürünü kara kutumuz ile direkt olarak iletişimden
ziyade, araya bir katman koyardık. Bu katman daha üst düzeyde yazdığımız komutları daha alt
düzeydeki komutlara birebir çevirir ve istediğimiz işi yapardı.

Araya katman koyduğumuz için de çok çeşitli optimizasyonlar, daha kara kutuya gitmeden yaptığımız
yanlışları görme fırsatı bulabilirdik. Bunun üzerine düşündüğümüzde aslında yapmamız gereken şeyin
çok basit olduğunu görebiliriz. Kara kutumuz için nasıl tanımlar yaptıysak, bunun için de birtakım
tanımlar yapıp onlar üzerinden ilerleyeceğiz. İşte bu tanımlara dilin grameri diyoruz. Aslında kendi
programlama dilimizi tanımlamaktayız şu anda:

```plain
topla 7
```

yazdığımızda ve bunu başka bir programa verdiğimizde, çıktı olarak bize kara kutumuzun yukarıdaki çıktısını verdiğinde programlama dilimizi tamamlamış oluyoruz:

```plain
00 000111
```

Bunu nasıl yaptığı 1 yıllık bir ders konusu, burada işlemeye vaktimiz olmayacak ama beyin jimnastiği
olması açısından ilk derleyicinin nasıl yazıldığı üzerine düşünmenizi isterim.

[hopper]: https://en.wikipedia.org/wiki/Grace_Hopper
[compiler]: https://en.wikipedia.org/wiki/Compiler
[firstcompiler]: https://cs.brown.edu/~adf/programming_languages.html#:~:text=In%201951%2C%20Grace%20Hopper%20wrote,do%20the%20work%20by%20hand.

### Assembly Dili

Yukarıda yazdığımız `topla 7` komutu bir assembly dili ve her işlemci için farklılık gösterecek.
Biz burada hayali kara kutumuza, yani işlemcimize bir assembly dili tanımladık. Bununla beraber x86
ve ARM için assembly dillerinin farklı olduğunu hatırlatmam gerekir.

- Dil nedir
- Bilgisayar tarihçesi, nelerden oluşur
- İkilik sistem ve assembly
- Nasıl programlıyoruz. CPU RAM Disk ilişkisi
- Python programı, REPL, bash/fish farksız
- Program çalıştıran program
