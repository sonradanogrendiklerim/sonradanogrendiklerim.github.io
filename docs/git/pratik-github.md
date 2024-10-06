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
kolaylaştırıyor. Sonrasında bu değişiklikleri `merge` ediyoruz. Bunu anlamak için bir önceki bölümdeki örnek üzerinden ilerleyebiliriz.

### Yeni Method

`test.py` içerisine yeni bir özellik ekleyelim ancak bunun diğer takım arkadaşlarımız tarafından gözden geçirilmesini istemekteyiz. Bunun için öncelikle yeni bir branch'e geçmemiz gerekiyor.

```sh
git pull
git checkout -b cikarma-islemi
```

Bu komut ile `cikarma-islemi`  adlı bir branch'e geçiyoruz. Bu branch `main` en son hangi noktada
ise onun devamı niteliğinde olacak. Bu yüzden remote ile local arasında bir değişiklik olmaması
gerekiyor. Bunu önlemek için branch açmadan önce `git pull` ile uzaktaki değişiklikleri yerelimize
alıyoruz.
