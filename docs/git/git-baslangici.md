---
title: Git Başlangıcı
description: Git sürüm kontrol sistemine giriş
---

Yazılım sektöründeyseniz git kesinlikle kullanacaksınız. Bu bölümde git'e giriş yapacağız ve en sık
kullanılan git komutlarını ve çalışma biçimlerini göreceğiz. Burada git'in en ince detaylarını
görmeyeceğiz, sadece bildiğim ve kullandığım kadarını anlatacağım. Daha detaylı bilgi için
internette birçok kaynak var, oralara bakabilirsiniz.

Git ilk başlayanlar için öğrenmesi zor bir araç. Konseptleri hemen anlamayı beklemeyin. Pratik
yaptıkça, problemlerle karşılaştıkça ve çözdükçe konseptler yerine oturacaktır. Bu yazı serisinde
pratik olarak neler yaptığımıza değineceğim. Tavsiyem burada okuduklarınızı bir de İngilizce
kaynaklardan, YouTube videolarından okuyup pekiştirmek olacaktır.

## Sürüm Kontrol Sistemleri

Sürüm kontrol sistemleri, adı üzerinde, kodumuzun sürümlerini kontrol etmek ve daha iyi biçimde
yönetmek için varlar. Sürüm kontrol sistemi olmadığı zaman kodumuzu versiyonlamak istersek
`xxx_final.zip`, `xxx_final_2.zip` gibi saçma dosyalar oluşturuyor olabilirdik. Bunun yerine daha
düzgün şekilde bize kodumuzu düzenlememiz için olanak sağlıyorlar.

Git de bunlardan bir tanesi. Git dağıtık bir sürüm kontrol sistemi. Yani herhangi bir merkeze bağlı
değil. Dağıtık olmasının ilk aşamada bizim için bir önemi yok, bunun ne demek olduğunu sonraki
bölümlerde göreceğiz. Git dışında başka sürüm kontrol sistemlerine örnek verecek olursak `svn`,
`cvs`, `mercurial` verebiliriz ancak aralarında en çok kullanılanı git.

## Konsol Aracılığı ile Kullanma

Git'i herhangi bir arayüz kullanmadan, konsol aracılığı ile kullanacağız. Bunun için konsola aşina
olmanız gerekmekte. Eğer yapmadıysanız daha önceki bölümlerde değindiğimiz üzere terminalinizi
güzelleştirebilir ve daha iyi kullanılabilir hale getirebilirsiniz.

Öncelikle Ubuntu üzerinde git yükleyelim.

```sh
sudo apt install git
```

Sonrasında `git --version` ile yüklendiğinden emin olalım.

## Git Reposu

Git reposu oluşturmadan önce yerelimizde repo kavramını git düzleminde incelememiz gerekiyor. İlerde
değineceğimiz üzere GitHub gibi araçlar kullanacaksak hali hazırda bir git reposu oluşmuş oluyor ve
biz bu repoyu uzaktaki bir git sunucusundan yerelimizde `klonluyoruz`. Yani yerelimizde bir
kopyasını oluşturuyoruz. Ancak elimizde bir GitHub reposu yoksa sadece kendi yerelimizde çalışıp,
değişiklikleri sonrasında GitHub'a atabiliriz. Bu açıdan `yerel` ve `uzak` repo kavramlarının
anlaşılması gerekmekte.

Buradan anlayacağımız git ve GitHub farklı kavramları temsil ediyorlar. GitHub bu noktada bir servis
sağlayıcı, git repoları ve diğer birçok özellikleri sunuyor ancak git kullanmanız için GitHub'a
ihtiyacınız yok. Başka git sunucuları ile çalışabilir, veya sadece yerelde çalışıp
değişikliklerinizi uzak bir sunucuya göndermeyebilirsiniz.

Biz ilk aşamada kendi yerelimizde çalışıp, herhangi bir git sunucusu ile etkileşime geçmeyeceğiz.
Temel komutları öğrendikten sonra GitHub ile nasıl çalışılır, en sık kullanılan komutlar ve çalışma
prensipleri nelerdir gibi konulara değineceğiz. Şimdi yerelimizde bir git reposu oluşturabiliriz.

Yapmanız gereken herhangi bir dizinde `git init` komutu çalıştırmak. Bunu yaptıktan sonra git reposu
oluşmuş olacaktır. Burada yerelimizde git reposu oluşturduğumuzu hatırlayalım. Yapacağımız
değişiklikler kendi yerel git repomuzda duracaktır.

```sh
mdkir -p src/sonradanogrendiklerim
cd src/sonradanogrendiklerim

git init
```

## Repo Durumu (status)

Şu anda elimizde boş bir repo var. Bunun içerisine henüz kodlarımızı eklemeye başlamadık. Reponun durumunu görmek için aşağıdaki komutu kullanıyoruz.

```sh
git status
```

```plain
❯ git status
On branch main

No commits yet

nothing to commit (create/copy files and use "git add" to track)
```

Burada branch kısmına takılmanıza gerek yok. Ön tanımlı olarak oluşturulan branch ismi `main` ve
bizim ana branchimiz oluyor. İlerde branch konusuna değineceğiz. Şimdilik sadece değişikliklerimizi
her daim `main` branchine yaptığımızı hatırlayalım.

Peki repomuza yeni dosya eklemek istediğimizde ne oluyor? Bunun için `test.py` isimli bir dosya
oluşturun ve içerisine aşağıdaki satırları yazın.

```python
def topla(a, b):
    return a + b
```

Tekrar `git status` komutunu çalıştırın ve komutun çıktısını inceleyin. Şu şekilde bir çıktı
verecektir.

```plain
❯ git status
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
 test.py

nothing added to commit but untracked files present (use "git add" to track)
```

`Untracked files` altında git'in haberi olmayan yeni bir dosya geldi ve bize bunu bildirdi. Şimdi
bizim yapmamız gereken ise bu dosyadan git'i haberdar etmek ve repo içerisine sokmak. Şu anda repo
içerisinde değil, sadece ne olduğunu bilmediğimiz bir dosya mevcut.

## Yeni Dosya Ekleme (add)

Bu başarabilmek için `git add` komutunu kullanmamız gerekmekte. Yeni dosyamızı, `test.py`, `git add`
komutu ile repomuza ekleyeceğiz. Bunun için aşağıdaki komutu kullanmamız yeterli.

```sh
git add test.py
```

Bu komuttan sonra reponun durumuna tekrar bakalım.

```plain
❯ git status
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   test.py
```

Görüldüğü üzere git'in artık bu dosyadan haberi var, ancak bu dosya henüz repo içerisine alınmış,
yani `commit` edilmiş değil. Yapacağımız tüm değişiklikleri `git add` ya da dosya çıkaracaksak
`git rm` komutu ile işledikten sonra son aşama olarak `commit` etmemiz gerekmekte. Commit için de
bir mesaj yazmamız yeterli.

Şimdilik commit mesajlarının nasıl olması gerektiği konusuna değinmeyeceğiz ancak burada açıklayıcı
bir mesaj olması bizim içim önemli. Commit, git'in en temel parçası ve diğer insanlarla kod
geliştirirken değişikliğin ne olduğunu düzgün bir biçimde anlatmak her daim bize avantaj
sağlayacaktır. Diğer türlü anlamsız commit mesajları ile neler olup bittiğini anlamak zor olmakta.

##  Repoya İşleme (commit)

Bunu işleme olarak çevirdim, belki yanlış bir çeviri olmuş olabilir ama yerelimizde yaptığımız
commit, sadece yerelimizde kalıyor, uzak bir sunucuya gitmiyor. Bunu aklımızdan çıkarmamamız gerekmekte.

```sh
git commit -m 'test.py dosyasını ekle'
```

```plain
❯ git commit -m 'test.py dosyasını ekle'
[main (root-commit) d6b50e3] test.py dosyasını ekle
 1 file changed, 2 insertions(+)
 create mode 100644 test.py
```

Görüldüğü üzere artık bu dosyamızı git içerisine aldık ve işledik. Burada dikkat etmemiz gereken
noktada herhangi bir uzak sunucu ile işlem yapmıyoruz, yaptığımız bütün işlemler kendi yerelimizde
meydana geliyor. Bu dağıtık sistemleri anlamak için önemli bir nokta. Herkesin bu şekilde
çalıştığını hayal edersek neden dağıtık sistem olduğunu anlamamızda bir nebze yardımcı olabilir.
İleride ortak nasıl çalışıldığı noktasını GitHub örneği ile daha iyi bir şekilde göreceğiz.

Burada `d6b50e3` şeklinde bir id oluştu. Git her commit'i takip etmek için benzersiz bir değer
atıyor ve bu commit artık paketlenmiş bir biçimde bu id ile eşleşmekte. Yani biz git kullanırken
`d6b50e3` numaralı committe ne oldu diye baktığımızda 1 dosyanın eklenmiş olduğunu ve yazdığımız
commit mesajı ile gönderilmiş olduğunu görüyoruz.

Burada 2 aşamalı bir gönderim söz konusu. `git add` komutu ile yapacağımız tüm değişiklikleri
`staged` hale getiriyoruz ve hazır olduğumuzda bu `staged` değişiklikleri `commit` ediyoruz.

!!! note "Commit mesajları için $EDITOR"
    Burada commit mesajını -m parametersi ile verdik ancak bunu vermek zorunda değiliz. Sadece `git
    commit` mesajı yazarak da commit edebiliriz. Bu durumda git `$EDITOR` ortam değişkeni içerisinde
    yazan editörü açacaktır. Editor içerisine yazıp dosyayı kaydettiğinizde commit mesajını
    oluşturmuş olacaktır. `$EDITOR` genellikle `vim` ya da `nano` olsa da siz başka bir editör
    tanımlayabilirsiniz.

## Dosya Değişikliği (diff)

Şimdi örnek olarak bir dosya değişikliği yapalım. Öncelikle `test.py` dosyamız sadece toplama
işlemini kapsıyor, biz buna çarpma işlemi de eklemek istiyoruz. Bunun için dosyanın sonuna aşağıdaki
satırları ekleyelim.

```python
def carp(a, b):
    return a * b
```

`git status` ile reponun durumunu öğrenelim. Burada `test.py` dosyasının değiştirilmiş olduğunu
göreceğiz.

```plain

❯ git status
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
 modified:   test.py

no changes added to commit (use "git add" and/or "git commit -a")
```

Peki nelerin değiştiğini nasıl göreceğiz? Bu noktada `git diff` komutu devreye giriyor. Repomuzda en
son commit ettiğimiz değişiklik ile şu anda olan değişikliğin farkını görmemizi sağlıyor.

```diff
❯ git diff
diff --git a/test.py b/test.py
index e354ed8..d5247ae 100644
--- a/test.py
+++ b/test.py
@@ -1,2 +1,6 @@
 def topla(a, b):
     return a + b
+
+
+def carp(a, b):
+    return a * b
```

Burada kırmızı ile işaretlenen satırlar çıkarılmış, yeşil ile işaretlenen satırlar eklenmiş anlamına
geliyor. Muhtemelen kariyerinizde diff çıktısı en çok inceleyeceğiniz şey olacaktır. Burada
çıkarılan satırlar olmadığı için bunları göremiyoruz, sadece eklenen satırlar mevcut.

Burada değişikliği gördük ancak bunu nasıl commit edeceğiz? Yine yukarıda değindiğimiz gibi `git add` ve `git commit` komutlarını ile bunu başarabiliyoruz.

```sh
git add test.py
git commit -m 'test.py: carp metodunu ekle'
```

```plain
❯ git commit -m 'test.py: carp metodunu ekle'
[main f3ed1ce] test.py: carp metodunu ekle
 1 file changed, 4 insertions(+)
```

Yine yukarıda gördüğümüz gibi ayrı bir commit numarası oluştu. `f3ed1ce` numarası artık bu commitin
benzersiz numarası. Bu benzersiz numaraların neden önemli olduğunu birazdan daha iyi anlayacağız.

!!! note "git add"
    `git add` komutu sadece dosya eklemek için değil, değişen dosyaları `staged` aşamasına eklemek
    için de kullanılmakta. Bu açıdan komut kafanızı karıştırmasın. `git add` yaptığımızda şu anki
    çalışma ortamımıza herhangi bir dosya değişikliği ekliyoruz anlamına gelmektedir.

## Repo Geçmişi (log)

Repo içerisine bir şeyler commit ediyoruz ancak neler commit edildiğini nasıl göreceğiz? Bunun için
`git log` komutu kullanılıyor. `git log` komutu çıktısından görebileceğimiz gibi her commitin
benzersiz bir numarası var ve bu numara ile commit içerisinde ne olup bittiğini görebiliyoruz.

`git show` komutu commit içerisinde ne olduğunu bize gösterecektir. `git show HASH` ile bu
commitlerin içeriğini görebilirsiniz. Sizdeki numaralar farklı olacaktır, o açıdan bu numaraları
gördüğünüz `git log` komutu çıktısı ile değiştirin.

Repo geçmişini görmek için sadece `git log` gibi araçlar yok. `tig` adlı araç repo geçmişini konsol
arayüzü ile görmenizi sağlıyor. Bu aracı tavsiye ederim. Yüklemek için aşağıdaki komutu kullanmanız
yeterli.

```sh
sudo apt install tig
```

Repo içerisindeyken `tig` yazmanız uygulamayı kullanmaya başlamak için yeterlidir. `ncurses`
arayüzüne sahip bu uygulamada `d` tuşuna bastığınızda commitin ne olduğunu görebilir ve `q` tuşu ile
geriye gidebilirsiniz. Ok tuşları ile inceleyeceğiniz commiti seçebilirsiniz.

## Sonuç

Temel git komutlarını bu bölümde işlemiş olduk ve sadece yerelimizde çalıştık. Yerelimizde çalışarak
git'in aslında uzak sunucuya ihtiyacı olmadını gördük ancak başka insanlarla çalışacaksak buna
ihtiyacımız olacak.

Bir sonraki yazıda pratik olarak GitHub ile nasıl kullanım sağlarız konusuna değineceğim. Git ve
GitHub'ın farklı kavramlar olduğunu tekrar hatırlatalım. GitHub bir servis sağlayıcı ve git
altındaki teknoloji. Bu yüzden git öğrenirken sadece GitHub'a bağımlı kalmamak gerektiğini ve bu
ayrımın yapılması gerektiğini düşünüyorum zira GitHub dışında GitLab vb. birçok servis sağlayıcı
mevcut. Temelleri öğrendikten sonra herhangi bir servis sağlayıcı ile çalışmak çok daha kolay
olacaktır.
