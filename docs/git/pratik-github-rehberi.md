---
title: Pratik GitHub Rehberi
description: GitHub ile pratik olarak neler yapabiliriz
---

Bir önceki bölümde yerelimizde git kullanarak temellerini öğrenmiştik. Bu bölümde pratik olarak
GitHub nasıl kullanılır kısmına değineceğiz. En çok kullanılan operasyonlardan başlayarak bunların
temelinde neler olduğunu açıklamaya çalışacağım.

Bu bölümde PR nasıl açılır, branch, merge ve rebase nedir gibi pratik olarak kullanılan konulara
değinilecek. Git'in branch ve merge işlemlerinini arka tarafta nasıl yaptığı gibi detaylara çok
takılmadan günlük hayatta kullanılacak pratik durumlara cevap verilecek.

## Yerelimizdeki Repoyu GitHub'a Göndermek

Önceki bölümde bütün değişiklikleri yerelimize gönderdiğimizden bahsetmiştik. Şimdi ise bu
değişiklikleri uzak bir sunucuya, yani GitHub'a göndermeye çalışacağız. Bunun için öncelikle bir
GitHub hesabına sahip olmamız ve bir repo oluşturmamız gerekmekte. GitHub'a kayıt olup SSH
anahtarınızı ekledikten sonra yeni repo oluşturma sayfasına gidin ve bir repo oluşturun. Bu repoyu
oluştururken `initialize this repository` kısmını işaretlemeyin, repoyu biz kendimiz oluşturacağımız
için bu adıma ihtiyacımız yok.

Bir sonraki adımda repoyu oluşturduktan sonra alttan ikinci kısımda bulunan komutlarla yerelimizdeki
repoyu GitHub'a göndereceğiz ancak burada birkaç kavrama değinmemiz gerekmekte.

```sh
git remote add origin git@github.com:sonradanogrendiklerim/test.git
git branch -M main
git push -u origin main
```

### Origin, Remote ve Push

Yukarıdaki komutu teker teker inceleyelim. İlk komutta `git remote add` ile yeni bir remote, yani
uzak sunucu ekliyoruz. Bu remote'un ismi `origin` ve adresi de `git@github.com` ile başlayan kısım.

!!! note "Remote Origin"
    Burada bu remote'un ismi origin olmak zorunda değil ama genel kullanım bu şekilde, ilk remote
    ismine origin denmekte. Başka remote'lar da eklenebiliyor ve bunların isimleri farklı
    olabiliyor, bunu aklımızdan çıkarmayalım. Şimdilik GitHub üzerindeki remote'un isminin origin
    olduğunu bilmemiz yeterli.

Sonrasında `git branch -M main` ile main branch'e geçiyoruz ve `git push -u origin main` ile az önce
eklediğimiz `origin` uzak suncusunun main branchına `push` yapıyoruz, yani uzak sunucuya
gönderiyoruz. Buradaki `-u` parametresi main için tekrar tekrar aynı komutu yazmamızı engelliyor.
İlerde `git push` yaptığımızda otomatik olarak `origin`e gideceğini belirtiyor.

Son kısım biraz karmaşık gelmiş olabilir ama takılmayın. Burada bilmemiz gereken nokta yerel ile
uzak sunucuların farklı olduğu ve yerelimizdeki değişikliği gönderirken `git push` komutunu
kullanıyor olmamız. Aynı zamanda nereye sorusunu cevabını da verebiliyor olmamız zira `git
push` yaptığımızda `origin` remote'u içerisinde işlem yapıyoruz.

Şimdi GitHub arayüzüne bakarsanız yerelinizdeki değişikliklerin oraya gönderildiğini görebilirsiniz.
`git push` ile elimizde ne varsa GitHub'a göndermiş olduk.

Burada gördüğümüz üzere ilk önce yerelimizde oluşturduğumuz repomuzu gönderdik. Yani yerel repomuza
`commit` etmemiz, uzak repoya göndermiş olduğumuz anlamına gelmiyor. Yerelde yaptığımız
değişiklikleri, commitleri, aynı zamanda bir de `git push` ile uzak sunucuya göndermemiz gerekmekte.

## PR Açmak

PR kelime anlamı ile `Pull Request` demek. Ana branch haricinde başka bir branch içerisinde
çalıştığınız ve gönderdiğiniz değişikliklerin ana branch'e alınmasına yani ana branch ile
birleştirilme isteğine verilen ad. PR kısmını anlamak için öncelikle branch'in ne olduğunu anlamamız gerekmekte.

### Branch

Dal olarak çevirebiliriz. Git içerisinde commit ettiğimiz her değişiklik bir önceki değişikliğin
devamı niteliğinde ve bir branch, dal içerisinde kümeleniyorlar. `main` branch bizim ana branchimiz,
ancak ana branch dışında bu branch'den dallanan başka branchler de olabilir. Bu konuyu anlatması
biraz zor, aşağıdaki diagram bu konuda yardımcı olabilir diye düşünüyorum.

![Branch](https://wac-cdn.atlassian.com/dam/jcr:a905ddfd-973a-452a-a4ae-f1dd65430027/01%20Git%20branch.svg)

Buradaki her yuvarlak bir commiti ifade ediyor. Mor ve yeşil renkte olanlar da ayrı birer branch'ı
temsil etmekteler.

### PR'ın Amacı

PR ile yaptığımız şey aslında oldukça basit. `main` branch'ten dallanan başka bir branch'i GitHub'a
yüklüyoruz ve GitHub bize `main` ile bu branch arasındaki farkı çıkararak diff görmemizi
kolaylaştırıyor. Sonrasında bu değişiklikleri `merge` ediyoruz. Bunu anlamak için bir önceki
bölümdeki örnek üzerinden ilerleyebiliriz.

### Yeni Metod

`test.py` içerisine yeni bir özellik ekleyelim ancak bunun diğer takım arkadaşlarımız tarafından
gözden geçirilmesini istemekteyiz. Bunun için öncelikle yeni bir branch'e geçmemiz gerekiyor.

```sh
git pull
git checkout -b cikarma-islemi
```

Bu komut ile `cikarma-islemi`  adlı bir branch'e geçiyoruz. Bu branch `main` en son hangi noktada
ise onun devamı niteliğinde olacak. Bu yüzden uzak ile yerel arasında bir değişiklik olmaması
gerekiyor. Bunu önlemek için branch açmadan önce `git pull` ile uzaktaki değişiklikleri yerelimize
alıyoruz.

Sonrasında çıkarma işlemi için metodumuzu ekleyelim. Dosyanın sonuna aşağıdaki satırları ekleyin ve
devamında `git status` ile reponun durumuna bakın.

```python
def cikar(a, b):
    return a - b
```

Görebileceğimiz üzere değişiklikler henüz git tarafından algılanmadı ve bu değişikliği `git add` ile
eklememiz gerekmekte. Bunun öncesinde nelerin değiştiğini `git diff` komutu ile görmek her zaman iyi
bir pratik olacaktır. Aşağıdaki komut ile değişikliklerimizi git'e alalım.

```sh
git add test.py
```

Sonrasında bu değişiklikleri `cikarma-islemi` branchımıza commit edelim.

```sh
git commit -m 'test.py: cikarma islemini ekle'
```

### PR Oluşturmak

Yaptığımız değişiklikler artık yerel github repomuzda duruyor. PR oluşturmak için bunları GitHub'a
göndermemiz, yani `push` etmemiz gerekmekte. `cikarma-islemi` branchında çalışırken aşağıdaki
komutla bu branch'ı GitHub'a gönderelim.

```sh
git push -u origin cikarma-islemi
```

Push işlemi sonrasında GitHub sonrasında size bir URL verecektir. Push sonrası konsolunuzda yazan
çıktıyı dikkatle okuyun. Bu URL'i ziyaret ettiğinizde PR açma ekranını göreceksiniz. PR açma
ekranından PR başlığını ve açıklamasını yazarak gönder'e basın. Tebrikler, ilk PR'ınızı açtınız.

Bu PR ekranında hangi değişikliklerin olduğunu, hangi commitlerin yapıldığını rahatça görebilir ve
değişen ilgili dosyalara yorum girebilirsiniz. Sonrasında PR'ı onaylayıp ana branch ile
birleştirebilirsiniz. Esasında bütün çalışma düzeni bundan ibaret. Özetlersek:

- Ana branch'i güncel tut
- Üzerinde çalışacağınız değişiklik için yeni bir branch aç
- Bu branch içerisinde değişiklikleri yap ve commit et
- Değişiklikler bitince ve hazır olduğunu düşündüğünüzde bunları `push` et.
- Push sonrası gelen URL'i ziyaret et ve PR açma ekranına eriş
- PR açıklamalarını gir ve PR aç
- PR hazır olduğunda ana branch'e `merge` et

### PR Sonrası Yapılanlar

PR oluşturduktan sonra başka bir değişiklik gerekiyorsa yine kendi yerelinizden `cikarma-islemi`
branchi üzerinde çalışabilir ve daha fazla commit atabilirsiniz. Sonrasında bu değişiklikleri `git
push` ile gönderebilirsiniz. Bu sefer PR otomatik olarak güncellenecek ve yeni commitler
görülebilecektir.

Özet olarak PR içerisinde düzeltilmesi gereken bir yorum aldıysanız bunu yerelinizde yeni bir commit
olarak düzeltip, `git push` ile commit ederek PR'ı güncelleyebilirsiniz.

PR `merge` edildiğinde, yani `cikarma-islemi` branchinde yaptığınız değişiklik ana branch ile
birleştirildiğinde artık `cikarma-islemi` branchine ihtiyaç olmayacaktır. Bu durumda yapmanız
gereken ana branch'i güncellemek olmalıdır. Merge edildiği zaman ana branch'e gelip `git pull` ile
yeni değişiklikleri almalısınız.

```sh
git checkout main
git pull
```

## PR Üzerinde Çalışırken Ana Branch'in Güncellenmesi

Bu çok sık karşılaşılan bir durumdur. Siz güncel ana branch'den dallanıp yeni bir branch
oluşturduğunuzda, ana branch içerisine başka değişiklik girmiş olabilir. Bunun için zaman zaman
üzerinde çalıştığınız branch'i `rebase` etmelisiniz, yani ana branch ile uyumlu hale getirmeniz
gerekmekte.

`cikarma-islemi` branchinden örnek verecek olursak siz bu değişikliği yaparken ana branch'e başka
bir commit girmiş, sizden önce başka birinin değişikliği `merge` edilmiş olabilir. Bu durumda
yapmanız gereken aşağıdaki komutlarla kendi branchınızı rebase etmenizdir. Buna
`git rebase workflow` denmektedir.

```sh
# Ana branchte iken (main)
git pull

# Kendi branchımıza geçelim
git checkout cikarma-islemi

# Ana branch ile senkronize olalım
git rebase main
```

Bu komutlar sonrasında `cikarma-islemi` branchı içerisine yaptığınız commitler, ana branch'in en son
durumu üzerine konumlandırılacaktır. Aksi halde eski bir commit üzerinden devam edeceğiniz için
dosya çakışması alma ihtimaliniz vardır. Bu durumu engellemek adına sık sık kendi branchinizi ana
branch ile senkronize etmeli ve rebase işlemini uygulamalısınız.

Rebase sonrası PR'ı güncellerken yapılan bu değişiklikleri `push` etmeniz gerekecektir. Ancak
history bozulduğu için normal şekilde `push` yapamayacaksınız, bunun yerine `force push` yapmanız
gerekmekte. `git push -f` komutu ile bunu başarabilirsiniz.

!!! warning "Force push"
    Gerekmedikçe kullanmanın sakıncalı olduğu bir komuttur. Git tarihini (history) değiştirdiği için
    bunu bozma ihtimaliniz fazladır. Bu açıdan **sadece** gereken hallerde force push kullanınız.

## Sonuç

Bu rehberde GitHub üzerinde nasıl PR oluşturulacağını, branch, rebase ve merge işlemlerinin neler
olduğuna değindik. En çok kullanılan, pratik olarak yapacağımız işlemler bunlar. Bunların dışında
dosya çakışması (conflict) yaşandığında neler yapılması gerektiğine değinmedik. Böyle bir durumda
neler yapacağınıza birkaç google araması ile ulaşabilirsiniz. Özellikle `git rebase workflow`
içerisinde üzerinde çalıştığınız dosya başka biri tarafından ana branch içerisinde düzenlenirse
çakışma alacaksınız. Bu çakışmaları giderip rebase işlemlerini tamamlamanız gerekmekte.

Bu pratik belge umarım işinize yarar. Bunun dışında değinmediğimiz birçok özellik mevcut. Özellikle
merge stratejileri, squash, merge commit, fast-forward gibi konulara değinmedik. Bunlar ilk aşamada
bilmemizin gerekli olmadığı terimler. Şimdilik PR açıp, yaptığımız değişiklikleri göndermemiz
yeterli. Zaten bu belgede de bunu amaçlıyorduk.

Git içerisinde öğrenilecek birçok terim var. Bunların hepsini burada yazamıyorum. Zaten bunları
öğrenirken de kullanarak öğrenmek en mantıklısı oluyor. Zamanı geldikçe, karşınıza hatalar çıktıkça
google araması ile bunları öğrenebilirsiniz.
