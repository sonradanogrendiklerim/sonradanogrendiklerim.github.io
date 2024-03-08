---
title: Ubuntu Kurulumu
description: Bilgisayar mühendisliği öğrencileri için işletim sistemleri ve Ubuntu kurulumu.
---

## İşletim Sistemi Nedir

Bilgisayarınızda birçok aygıt bulunur. Bu aygıtlara örnek olarak işlemci, ekran kartı, sabit disk,
ve USB portları verebiliriz. [İşletim sistemi][os-simplified]{:target="_blank"} bu aygıtları bir
şekilde kullanmanızı sağlar ve işletim sistemi sizin de yazacağınız herhangi bir `programdan`
farksızdır. İşletim sistemi sadece çok daha farklı bir katmanda, çok daha farklı işler yapar. Hatta
işletim sistemlerine `programların programı` diyebiliriz çünkü diğer programların yönetimini de bu
üstlenir. Sonuç olarak bir programı çalıştırmak, bu çalışan programın yazacağı/okuyacağı dosyaları
sunmak, hata anında çalışan programa neler yapılacağına karar vermek işletim sisteminin bazı
görevlerindendir. Detayları daha sonra göreceğiz ancak şimdilik işletim sisteminin `programların
programı` olduğunu bilmemiz yeterli olacaktır.

[os-simplified]: https://simple.wikipedia.org/wiki/Operating_system

## Kurulum

Burada adımlarla kurulumun nasıl gerçekleştirildiğine değinmeyeceğim. YouTube'da birçok video
mevcut. Dikkat etmeniz gereken USB bellek aracılığı ile bilgisayarınıza gerçek bir kurulum yapmanız
ve VirtualBox gibi sanallaştırma araçlarını kullanmıyor olmanız. Bu belgenin sonunda
bilgisayarınızda bir Ubuntu kurulumu olacak ve açma/kapama tuşuna bastığınızda hangi işletim
sistemini kullanmak istediğinizi seçeceksiniz. Veya seçmeyeceksiniz çünkü artık birer mühendis
adayısınız ve Windows kurulumuna çok az ihtiyacınız olacağı için diskin tamamına Ubuntu kurmak
isteyebilirsiniz :)

Aşağıdaki video Windows ve Ubuntu'yu aynı anda kullanmak için neler yapmanız gerektiğini net bir
şekilde anlatıyor. Üreticiden üreticiye hangi tuş kombinasyonlarını kullanmanız gerektiği
değişebilir ancak mantık aşağı yukarı aynı.

- Bilgisayar açılırken bir kombinasyon ile bilgisayarı ne ile açmak istediğinizi seçiyorsunuz.
- Kurulum yapılmadıysa bu seçim ekranından USB belleği seçiyorsunuz ve kurulumu yapıyorsunuz.
- Devamında ne kullanmak istiyorsanız açılırken bu seçimi gerçekleştiriyorsunuz

<!-- markdownlint-disable-next-line -->
<div class="video-wrapper">
  <iframe width="1280" height="720" src="https://www.youtube.com/embed/W-RFY4LQ6oE" frameborder="0" allowfullscreen></iframe>
</div>

<br>
Unutmayın. Bu işlem sabit diskinizi biçimlendirecek. İçerisinde var olan dosyaları kaybetme ihtimaliniz yüksek. Bu açıdan [Bölüme Başlarken][bolume-baslarken] kısmını dikkatle ve tekrar okumanızı öneririm.

[bolume-baslarken]: ../bilgisayar-muhendisligine-giris/baslarken.md

## İlk Ayarlar

İlk ayarlar ve basit kullanım için de YouTube videolarını takip edebilirsiniz. [Linux TV][linux-tv]
bu noktada sizlere yardımcı olacaktır. Nasıl uygulama yüklenir, temel ayarlar nasıl yapılır gibi
konuları bu kanaldan öğrenebilirsiniz.

Daha da önemlisi bunları kendiniz keşfedebilirsiniz. Artık önceki dosyalarınız yerli yerinde olan
veya olmayan bir Ubuntu bilgisayara sahipsiniz ve istediğiniz zaman tekrar kurabilirsiniz.
Dolayısıyla bunu bozun, tekrar yapın, keşfedin, bozarken neden bozduğunuzu sorun ve öğrenmeye
çalışın. Mühendis olmanın gerekliliklerini bu şekilde yerine getirebilirsiniz.

İçerik bulma konusunda tavsiyem İngilizce içerikli kanalları tüketmek olacaktır. Arama yaparken
İngilizce anahtar kelimeleri kullanmanız daha yararlı olur. Maalesef Türkçe içerik konusunda sıkıntı
çekmekteyiz.

[linux-tv]: https://www.youtube.com/watch?v=i2jMQRgfHek&list=PLrW4kXWyzgoJgN3Ebo3LGoyJvNZiDMWi9&index=2

## Hemen Kod Yazalım

Herkesin aklındaki soruya şimdiden cevap verme gereği hissediyorum. Cin olmadan adam çarpmaya
çalışmıyoruz. Öncesinde Windows ortamında deneyiminiz olmuş, ekrana `C#` kullanarak `hello world`
yazmış ve kendinizi büyük bir programcı gibi hissetmiş olabilirsiniz. Buna en hafif tabiri ile bir
sanrı diyebiliriz.

Bu blog ile yapmaya çalıştığım oldukça yavaş bir şekilde, sonradan öğrendiklerimi, yine yavaş ve
özümseyerek aktarmak. Bu zaman alan bir süreç ve hız bu noktada en az isteyeceğim özellik. Eğer
buradan kod yazmaya ve konseptleri hızlı bir şekilde anlamaya çalışmak gibi bir beklentiniz varsa
okumayı burada sonlandırabilirsiniz.
