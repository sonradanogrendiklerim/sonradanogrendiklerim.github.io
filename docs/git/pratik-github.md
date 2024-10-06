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
