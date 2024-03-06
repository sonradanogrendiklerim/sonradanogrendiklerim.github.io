---
title: Python Programlama Dili ve Modern Geliştirme
---

## Giriş

Önceki bölümde programlama dillerinin hangi ihtiyaçtan, nasıl ortaya çıktığına değindik.
[Python][python] da bunlardan bir tanesi. Bu yazıda Python kurulumu, dile basit bir giriş, modern
Python geliştirirken kullanılan araçlar, paket yöneticisi, sanal ortam (virtual environment) gibi
konulara değineceğiz.

Buradaki amaç dili öğretmek değil, geliştirme yaparken sektörde sık kullanılan araçları sizlere
tanıtmak ve geliştirmenizi kolaylaştırmak. Dili daha fazla öğrenmek isterseniz Python'un
[wikisi][wiki] ile birlikte birçok YouTube videosu ve makaleler mevcut.

[python]: https://www.python.org
[wiki]: https://wiki.python.org/moin/BeginnersGuide/Programmers

## Python Kurulumu

Önceki yazılarda Ubuntu kullanmamızın yararlı olacağını belirtmiştim. Bundan sonrasında yazacağımız
komutlar her zaman `Ubuntu 22.04` üzerinde olacak. Daha önce güzelleştirilmiş
[terminalinizi](../ubuntu/terminali-guzellestirelim.md){:target="_blank"} açarak aşağıdaki komutu
girin:

```sh
sudo apt-get install python3.10 python3.10-venv
```

Python yüklendiğinde aşağıdaki çıktıyı görmeniz gerekmekte:

```sh
❯ python3 --version
Python 3.10.12
```

Artık terminalimize `python3` komutunu yazarak kullanmaya başlayabiliriz.

## Python Kullanımı

Terminalimize `python3` yazdığımızda fish veya bash ile benzer şekilde metin tabanlı bir arayüz bizi
karşılayacak. Bu arayüze [REPL][repl] `(Read-Eval-Print-Loop)` denmekte. Aslında terminal de aynı
şekilde bir REPL, sadece bu ismi şu anda hazır olduğumuz için belgenin bu kısmında duyuyoruz.

Python konsolu içerisine aşağıdaki komutu yazdığınızda programlamaya başlamış oluyoruz:

```py
print("merhaba dünya")
```

Görebileceğiniz gibi ekrana çok kolay bir biçimde bir şeyler bastırabildik. Bunu bir önceki bölümde Assembly ile yapmak çok zordu ve hataya açıktı. Buradan anlıyoruz ki diller aslında bizim işimizi kolaylaştırıcı bir araç. Dilerseniz burada bir toplama işlemi tanımlayalım ve ne kadar kolay çağrılabilir olduğunu görelim:

```python
def topla(a, b):
    return a + b

topla(3, 7)
```

Bunları şimdilik konsolda, interaktif şekilde yaptık ancak muhtemelen kodlarımızın kalıcı olmasını
isteyeceğizdir. Bunun için `.py` uzantılı bir dosya oluşturup içerisine yazabiliriz. Yeni shell komutlari ile bu dosya ve dizinleri oluşturalım.

```sh
cd ~
mkdir src
touch src/ilkadim.py
```

- __cd__: Bunu daha önce [terminal makalesinde](../ubuntu/terminali-guzellestirelim.md#ayar-eklemeye-giris) görmüştük. Bu komut şu anda bulunduğumuz dizini değiştiriyor.
- __mkdir__: `Make directory` anlamına geliyor. Yeni bir dizin oluşturuyor.
- __touch__: Şef dokunuşu. Boş bir dosya oluşturuyor.

Şimdi grafik arayüzünüzden ev dizininde bulunan `src` klasörüne giderek `ilkadim.py` dosyasını metin editörü ile açın ve içerisine aşağıdakileri yazın:

```py
print("merhaba dünya")

def topla(a, b):
    return a + b

topla(3, 7)
```

Sonrasında konsolunuza dönün ve aşağıdaki komutu girin:

```sh
python3 ilkadim.py
```

Ekrana sadece `merhaba dünya` bastığını göreceksiniz. Python konsolu ve normal şekilde çalıştırma arasındaki fark var. Python konsolu bir REPL olduğu için en son yazdığınız komutun çıktısını her daim ekrana basacaktır ancak normal şekilde çalıştırdığımızda ekranda bir şey görmüyor, sadece topluyoruz. Ekranda bunu görmek için toplama sonucunu bir değişkene atayıp bastırabiliriz:

```py
toplam = topla(3, 7)
print(toplam)
```

Sonucunda tüm programımız şu hali aldı:

```py
print("merhaba dünya")

def topla(a, b):
    return a + b

toplam = topla(3, 7)
print(toplam)
```

Tekrar konsola dönüp `python3 ilkadim.py` çalıştırdığınızda aşağıdaki çıktıyı görmeniz gerekmekte:

```plain
❯ python ilkadim.py
merhaba dünya
10
```

[repl]: https://en.wikipedia.org/wiki/Read–eval–print_loop
