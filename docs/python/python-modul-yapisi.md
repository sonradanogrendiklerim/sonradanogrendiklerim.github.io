---
title: Python Modül Yapısı
description: Python modülleri nasıl çalışır, proje ve modül yapısına giriş.
date: 2024-03-09
---

Python dilinde ilerlemeden önce modül yapısının anlaşılmasının daha yararlı olduğunu düşünüyorum.
Dili öğrenmeye girişte genellikle tek bir dosya içerisinde birtakım sınıflar, metodlar ve
fonksiyonlar tanımlanarak örneklendirilir ancak bizim buradaki hedefimiz öncelikli olarak bunların
nasıl çalıştığı ve nasıl bir araya geldiğini görmek. Bunu kavradıktan sonra Python örneklerini ve
dili anlamaya çalışacağız çünkü tek bir dosya örneği birden fazla dosyaya çok çabuk şekilde
evriliyor.

Burada fikir sahibi olacağımız konu Python'un kendi içerisinde bir kodu nasıl çalıştırdığı ve
`import` anahtar kelimesi ile yazdığımız satırları nasıl yorumladığı. Hatırlarsanız faktöriyel ve
web sayfası örneklerinde [math][math]{:target="_blank"} ve [requests][requests]{:target="_blank"}
modüllerini kullanmıştık ancak nasıl çalıştıklarına
[terminal komutu nasıl çalışır][terminal]{:target="_blank"} makalesindeki gibi değinmemiştik. Bu
bölümde buna değineceğiz.

## Modüller Nasıl Yüklenir

Öncelikle Python'ın bu modülün nerede olduğunu bulması gerekiyor. Bunu yaparken de kullandığımız
shell nasıl ortam değişkenlerini kullanıp bir uygulamayı buluyorsa, Python da kendi içerisinde
modülleri aradığı dizinlere bakıyor. Bu dizinlerin neler olduğunu `sys` modülünü yükleyerek
görebiliyoruz.

Sanal ortamınızı [aktive ettikten][activate]{:target="_blank"} sonra `ipython` komutunu çalıştırın
ve aşağıdaki kod parçacığını girin:

```py

In [1]: import sys

In [2]: sys.path
```

!!! note "IPython Kodu Kopyalama"
    Burada direkt olarak `In [1]:` satırları ile kodu kopyalayıp IPython içerisine
    yapıştırabilirsiniz. IPython otomatik olarak bu satırları almayacak ve kodu çalıştıracaktır.
    IPython hangi komutun çıktısının ne olduğunu `Out [2]` satırı ile göstermekte ve bize yardımcı
    olmakta.

Sonuç olarak aşağıdakine benzer bir çıktı göreceksiniz.

```py
Out[2]: 
['/home/eren.linux/src/sonradanogrendiklerim/venv/bin',
 '/usr/lib/python310.zip',
 '/usr/lib/python3.10',  # ---> Python'un kendi içerisinde gelen modülleri
 '/usr/lib/python3.10/lib-dynload',

 '', # ---> içinde bulunduğumuz dizin

 '/home/eren.linux/src/sonradanogrendiklerim/venv/lib/python3.10/site-packages']
     # |
     # |----> dışarıdan yüklediğimiz paketlerin bulunduğu sanal ortam dizini
 
```

Burada gördüğümüz çıktıdan anladığımız üzere Python herhangi bir `import` anahtar kelimesi
gördüğünde bu dizinlere __sırası ile__, __teker teker__ bakıyor ve modülü yüklemeye çalışıyor.

## Kendi Modülümüzü Oluşturalım

Bunun için tek yapmamız gereken proje dizininde `py` uzantılı bir dosya oluşturmak.
[ilkadim.py][ilkadim]{:target="_blank"} içerisindeki toplama işlemi bu noktada güzel bir tercih
olabillir. Tek bir dosya yerine toplama işlemini ayırıp, ayrı bir modülden çağıracağız.

Öncelikle `matematik.py` isimli bir dosya oluşturun ve toplama işlemini buraya taşıyın:

```py
def topla(a, b):
    return a + b
```

Sonrasında `ilkadim.py` içerisindeki aynı kodu silin ve `import` ile bu modülü yükleyin:

```py
import matematik

print("merhaba dünya")

toplam = matematik.topla(3, 7)
print(toplam)
```

Tebrikler. İlk modülümüzü oluşturduk. Python modül ararken `matematik.py` dosyasını diğer dizinlerde
bulamadı, şu an bulunduğumuz dizine sıra geldi, buldu ve yükledi.

Burada sadece dosya isiminden giderek modülü yükledik ancak birden fazla dosyaya sahip olan modüller
de karşımıza çıkacak, [requests][requests]{:target="_blank"} modülünde olduğu gibi. Bu modüller bir
dizin içerisinde yer alıyor ve birden fazla dosyaya sahip olabiliyor. Şimdi dizin içerisindeki
modüllerin nasıl yüklendiğine bakalım.

## Modül Dizini ve `__init__.py`

`requests` modülüne bakacak olursak `site-packages` dizinine göz atmamız yeterli.

```sh
❯ pwd
/home/eren.linux/src/sonradanogrendiklerim

❯ ls venv/lib/python3.10/site-packages/requests/
__init__.py  __version__.py  adapters.py  auth.py  ...
```

Gördüğümüz gibi `requests` modülü bir dizin olarak yer alıyor ve `import requests` satırı
çalıştırıldığında bu dizinden okunup modül yükleniyor. Modülün çeşitli dosyalara ayrıldığını
görebiliriz. Bu bize bütün kodu tek bir dosyaya yazmamamız için olanak sağlıyor. Peki burada modülün
giriş kodu nerede? Bu da `__init__.py` tarafından sağlanıyor.

Python'da herhangi bir dizin içerisinde `__init__.py` dosyası varsa, bu dizin modül dizini olarak
kullanılmakta. Dolayısıyla bu örnekte `import requests` yazdığımızda bu dizinin içerisindeki
`__init__.py` yüklenmekte. Genellikle bu dosya içerisinde diğer `import` edilecek satırlar yer
alıyor.

## Kendi Modül Dizinimizi (Paketimizi) Oluşturalım

`matematik.py` dosyası şu anlık işimizi görse de farzedelim ki birçok matematik işlemini ayrı
şekilde tutmak istiyoruz. Bunun için `matematik` isimli bir dizin oluşturabiliriz. Dizini oluşturun
ve içerisine `__init__.py` adlı bir dosya yerleştirin. Bu dosyanın içerisine yine toplama işlemi
kodunu koyun. Böylelikle dizini modül olarak kullanmış olacağız. Sonrasında `matematik.py` dosyasını
silmeyi unutmayın çünkü öncelikli olarak bu yüklenecektir, proje içerisinde olmasını istemiyoruz.

```py
import matematik
```

Satırını çalıştırdığımızda artık dizinden okuyacaktır. Dilerseniz burada bir nefeslenelim ve ne
yaptığımızın farkında olalım.

- Modül yazmadan `ilkadim.py` örneğini oluşturduk ve toplama işlemi yaptık
- Toplama işlemini ayırmak istedik ve `matematik.py` isimli bir dosya oluşturduk
- Bu dosyayı `import matematik` şeklinde yükleyip çalıştırdık
- Sonrasında bunu bir dizin içerisine aldık ve Python'a dizini modül olarak kullanmasını söyledik
  `(__init__.py)`
- `__init__.py` içerisine koyduğumuz toplama işlemi kodu aynı şekilde çalıştırabildik ve modül
  dizini içerisinden bir modül yükleyebildik.

Bunların hepsi Python'un modül yükleme yöntemi ile gerçekleşebildi.

### Modül Dizininde Ayrı Modüller

Örnek olması açısından bütün kodu `__init__.py` içerisine yerleştirdik ancak bu yaptığımız bir
pratik değil. Genellikle bu dosyayı dizini modül dizini olarak kullanmak için boş olarak
yerleştiriyoruz ve içerisine ayrı dosyalar koyuyoruz. Toplama işlemini ayırmak istersek `matematik`
dizinine `topla.py` koymamız gerekmekte. Şimdi `__init__.py` içerisine koyduğumuz kodu `topla.py`
içerisine koyalım ve `__init__.py` dosyası boş kalsın. Durum bu şekilde olduğunda modülü yüklemek
için ayrı bir `import` kullanmamız gerekecek:

```py
In [1]: from matematik import topla

In [2]: topla.topla(3,3)
Out[2]: 6
```

Bu şekilde kullandığımızda `matematik` modülünden `topla` modülünü programımıza dahil etmiş olduk.
Örneği devam ettirecek olursak `carp.py`, `bol.py` gibi dosyaları oluşurabilirdik.

!!! note "Boş ve dolu `__init__.py` dosyası"
    Burada not etmemiz gerekir ki genellikle boş koysak da `__init__.py` dosyasının ileri kullanımı
    mevcut. Yukarıdaki örnekte `from matematik import topla` satırında toplama modülünü direkt
    olarak import edebildik ancak `import matematik` yazdığımızda Python modül sisteminde öncelikle
    `__init__.py` yüklendiği için elimize boş bir modül gelecektir. Bunu `matematik` modülü import
    edilirken birtakım kolaylıklar sağlamak için kullanabiliriz. Bunu da `__init__.py` içerisinde
    yapıyoruz ancak şu an ileri kullanıma ihtiyacımız yok. Aklımızda durması yeterli.

## Sonuç

Python modül yapısının nasıl olduğunu, dosyadan ve dizinden nasıl yüklendiğini ve kendi modülümüzü
nasıl oluşturacağımızı gördük. Modül yapısının daha fazla incelikleri var ancak şimdilik bunlar
bizim için yeterli. Artık kod yazarken modüllere dikkat edip, neyin nerede olduğunun daha fazla
farkında olacağız. Bundan sonrasında herhangi bir projeye baktığımızda modüllerin nerede olduğunu ve
neyin nasıl çağrıldığını bilerek hareket edeceğiz. Bu bize kodu anlamada zaman kazandıracaktır.

Modül yükleme detaylarını merak ediyorsanız bundan sonrası için
[Python belgelerine][modulesystem]{:target="_blank"} göz atabilirsiniz.

[math]:     ../python/pythona-giris-ve-modern-gelistirme.md#biraz-matematiksel-islem
[requests]: ../python/pythona-giris-ve-modern-gelistirme.md#web-sayfas-ziyareti
[activate]: ../python/pythona-giris-ve-modern-gelistirme.md#pip-ve-virtualenv
[terminal]: ../linux/terminal-komutu-nasil-calisir.md
[ilkadim]:  ../python/pythona-giris-ve-modern-gelistirme.md#python-kullanm
[modulesystem]: https://docs.python.org/3.10/reference/import.html#packages
