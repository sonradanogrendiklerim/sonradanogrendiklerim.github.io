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

[python]: https://www.python.org

## Bilgisayar Nasıl Çalışır

### İşlemci

İşelemci dediğimiz çok küçük ve güçlü elektronik devre parçası sadece 1 ve 0, yani ikilik sistemi
anlıyor. Burada dünyada sadece 1 işlemci ya da işlemci mimarisi olduğu anlaşılmasın, yine
programlama dillerinde olduğu gibi yüzlerce, belki binlerce işlemci ve işlemci mimarisi var. Lakin
en çok x86 ve ARM kullanmaktayız. Telefonlarımızda düşük güçte yüksek performans verebildiği için
ARM, sunucularda veya kişisel bilgisayarlarımızda ise x86 yaygın olarak kullanılmakta. Son
zamanlarda ARM mimarisi sunucu performasına gelmiş olsa da ARM ve x86 karşılaştırması şimdilik
konumuz değil.

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

### RAM

### Disk

## Notlar

- Dil nedir
- Bilgisayar tarihçesi, nelerden oluşur
- İkilik sistem ve assembly
- Nasıl programlıyoruz. CPU RAM Disk ilişkisi
- Python programı, REPL, bash/fish farksız
- Program çalıştıran program
