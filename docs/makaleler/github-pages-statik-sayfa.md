---
title: Github Pages ile Statik Sayfa Sunmak
description: Sonradan öğrendiklerim sayfası statik olarak nasıl sunuluyor.
---
<!-- markdownlint-disable MD034 -->

Bir web sayfası yapmak için ihtiyacınız olan çok az şey var. Bunlardan bir tanesi domain, ve bu
domaine gittiğimiz zaman içerik sunacak bir web sunucu. Bunun haricinde herhangi bir şeye
ihtiyacınız yok. Bu sayfa için konuşuacak olursak domainimiz `sonradanogrendiklerim.com` ve web
sunucumuz [Github Pages][github-pages]. Bu belgede sayfayı statik olarak nasıl sunduğumuzu
inceleyeceğiz.

## Domain

Kişisel bir tercih olarak domainleri [namecheap.com][namecheap]{:target="_blank"} üzerinden almayı tercih ediyorum. Yıllardır kullanmakla birlikte arayüzleri ve sundukları müşteri desteğinden memnunum. Bu açıdan öncelikle tercih ettiğiniz yerden bir domain edinin.

## Github Pages

Burada dikkat etmemiz gereken nokta tek bir hesabın ya da organizasyonun bir tane ana domaini
olabiliyor. Dolayısıyla kişisel hesapta bir sayfa varsa, buna ek olarak sayfa açamıyoruz. Benim
durumumda `eren.github.io` reposunda `erenturkay.com` tanımlı. Bu da tek bir statik sayfa anlamına
geliyor. Bu yüzden kişisel hesabıma bağlı [sonradanogrendiklerim][sonradan] adlı ayrı bir
organizasyon açmak durumunda kaldım.

!!! note "eren.github.com"
    Github Pages ilk açıldığında repo isimleri `.github.com` bitmesi gerekiyordu. Bu sonrasında değişti ve artık `.github.io` ile bitmesi gerekiyor.

Domaini aldıktan sonra organizasyon ya da ana hesabınızla aynı olan bir repo açın ve sonu
`.github.io` ile bitsin. Örnek olarak ana kullanıcı adım olan `eren` için
[eren.github.io][eren-github]{:target="_blank"}, organizasyon olan `sonradanogrendiklerim` için
[sonradanogrendiklerim.github.io][sonradan-io]{:target="_blank"} gösterebiliriz.

Devamında `docs/` dizini altında `CNAME` adlı bir dosya oluşturun ve içerisine domaininizi yazın.
Sonradan öğrendiklerim için bu dosyanın içeriği `sonradanogrendiklerim.com`. Bunun Github
içerisindeki ismi `Custom Domain`. [Kendi belgeleri][github-custom] daha uzun şekilde anlatmakta.
Buraya da bakmayı tercih edebilirsiniz.

!!! note "CNAME dosyası"
    Bu dosyanın normalde reponun root dizininde olması gerekmekte. Burada `docs/` dizini altına
    koymamızın nedeni siteyi `mkdocs` ile üretiyor olmamız. Eğer `mkdocs` dosyalarının bulunduğu
    `src` branchi altında `CNAME` dosyasını koyarsak bu dosya site üretildiğinde ana branch'e
    gönderilemeyecek, dolayısıyla sayfamız çalışmayacaktır.

!!! tip "Git ve Github üzerine"
    Daha önceden deneyimi olmayanlar git ve github kullanımı için başka makalelere göz atmaları
    gerekebilir. Terminolojik olarak konuşursak bu dosyaların sonuç itibariyle repo içerisinde push
    edilmiş halde bulunması gerekiyor.
    Mosh Hamedani'nin [git başlangıç videosu][mosh-video] ve [Oh My Git!][oh-my-git] interaktif oyununu bu noktada iyi bir başlangıç olabilir.

## Statik Sayfa Testi

Biraz sonra denemek için repo içerisine `index.html` koymak iyi bir fikir olabilir. Bu dosyayı
oluşturun ve içerisini dilediğiniz şekilde doldurun. Ben burayı aşağıdaki kod parçacığı ile
doldurmayı tercih ettim zira tarayıcı ile açtığımızda test sayfayı görebileyim.

```html
<html>
    <head><title>Github Pages Test Sayfası</title></head>
    <body><h1>TEST</h1></body>
</html>
```

## DNS Yönlendirmesi

Domainimizi aldık, web sunucusu zaten hazırdı (github pages), gerekli ayarları yaptık ve artık
yönlendirmeye hazırız. Burada domaini aldığınız yerden `A` kaydı olarak aşağıdakileri girdiğinizde
statik sayfaları sunmaya başlayabileceksiniz. Bu kayıtlar Github Pages sunucuları ve yukarıda
hesabımızla bağlantılı sayfaları sunuyorlar.

```plain
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

Bu noktada dikkat edilmesi gereken şey bu kayıtların `APEX` olarak girilmesi, yani bu kayıtlar domainin köküne (root) kısmına girilmesi gerekmekte.

!!! danger "Yanlış kayıt"
    www.sonradanogrendiklerim.com

!!! success "Doğru kayıt (APEX)"
    sonradanogrendiklerim.com

TTL değerleri kendini bulduğunda statik sayfanız böylelikle hazır olmuş olacak. Tebrikler.

## CloudFlare NS Sunucuları (Opsiyonel)

Domain satın aldığınız servis DNS sunucu hizmeti de yüksek ihtimalle veriyor. Bu hizmeti
kullanabilirsiniz ancak kişisel olarak `namecheap` sunucuları yerine `CloudFlare` kullanmayı tercih
ediyorum. Belgenin bu bölümü sonralarda olsa da aslında domain alındıktan sonra yapılması
gerekmekte.

Satın alma işleminden sonra `CloudFlare` üzerinde bir proje oluşturun ve NS sunucu isimlerini alın. `sonradanogrendiklerim.com` projesi için CloudFlare aşağıdaki sunucuları kullanmamı istedi.

```plain
alex.ns.cloudflare.com
iris.ns.cloudflare.com
```

Devamında domain aldığınız yerde APEX kaydı olarak size verilen sunucuları girin. Bunları yaptıktan
sonra domain kayıtlarınızı artık satın aldığınız yerden değil, CloudFlare üzerinden yapacaksınız.

## MkDocs Material

Statik sayfamızı artık oluşturduk. Domaine eriştikten ve `index.html` içerisindeki yazıları
gördükten sonra işimiz aslında bitiyor ama siteyi güncellememiz ve yeni yazılar eklememiz de
gerekmekte. İşte bu noktada [MkDocs][mkdocs]{:target="_blank"} devreye giriyor.

Bu proje bir statik site oluşturma projesi. Yani siz başka bir şekilde ve yapıda yazılarınızı
yazıyorsunuz ve sizin yerinize statik olarak web sayfası oluşturuyor. Bunu da kendi yöntemi ile
Github Pages üzerinde sunuyorsunuz. Bu yöntem ile çok değişmeyecek web sayfalarını sadece domain
ücreti ödeyerek gerçekleyebiliyorsunuz.

Ben `hugo`, `jekyll`, `pelican` gibi bilindik projeleri denedikten sonra MkDocs ile rastlantısal bir
şekilde karşılaştım ve yazı yazmanın en kolay yolunun bu olduğuna karar verdim. Diğer projeler
başarılı olsalar da statik sayfa oluşturmayı kolaylaştırmak yerine statik sayfa için size birer
framework sunuyor ve geri kalanını size bırakıyor. Dolayısıyla öncelikle statik sayfalarınızı
oluşturmak, sonrasında yazılarınızı yazmak durumunda kalıyorsunuz. MkDocs bu noktada yine framework
sunuyor ancak [material teması][material]{:target="_blank"} ile tek bir ayar dosyası ve dizin yapısı
ile sayfa oluşturmaya başlayabiliyorsunuz. Belki diğer projeler de bu şekilde kolay kullanılıyordur
ancak ben becerememişimdir.

### Kurulum

Projenin [kurulum sayfasından][material-start]{:target="_blank"} ilerleyebilirsiniz. Bu bir python
projesi ve `pip` ile yükledikten sonra kullanabilirsiniz.

```sh
pip install mkdocs-material
```

### Ayarlar

```sh
mkdocs new .
```

O anki dizinde minimal ayar oluşturacaktır. Bütün yazılar `docs/` dizini içerisinde yer alıyor ve
tek bir `mkdocs.yml` ayar dosyası var. Material teması ve bu sayfanın ayarlarını örnek almak için [github sayfasını][sonradan-config]{:target="_blank"} ziyaret edebilirsiniz.

### Kullanım

```sh
mkdocs serve
```

<http://localhost:8000> üzerinden erişilecektir. Sayfayı geliştirme aşamasında bu yeterli olacaktır
ancak yayına alma noktasında `mkdocs` belgeleri işimize yaramamakta. Bu belgede `main` branch mkdocs
dizinini barındırmakta, yayına alırken `gh-pages` branchı oluşturulmakta ve PR açılmakta.

Ben bunun yerine site dosyalarını `src` branchi içerisinde tutup, oluşturulan siteyi direkt olarak
`force push` ile gönderme taraftarıyım. Yani belgede yazan PR kısmını atlayıp, siteyi hemen
gönderiyoruz. Bunu aşağıdaki komutlar ile yapabilirsiniz:

```sh
rm -rf .cache
mkdocs gh-deploy
git push origin gh-pages:main -f
```

!!! note ".cache dizini"
    Bu sitenin ayar dosyasında `social` eklentisi mevcut. Bu eklenti sosyal medyada paylaştığımız
    linkler için resim üretmekte. Siteyi yayına alırken ürettiği resimleri tekrar üretmemek için
    reponun kök dizininde `.cache` adlı bir dizin kullanıyor. Yazdığımız yazı güncellendiğinde
    ise tekrar üretmiyor. Dolayısıyla siteyi yayına almadan önce `social` ile üretilen bütün
    resimleri silip tekrar üretmesini sağlıyoruz.

[github-pages]: https://pages.github.com
[namecheap]:    https://www.namecheap.com
[sonradan]:     http://github.com/sonradanogrendiklerim
[sonradan-io]:  http://github.com/sonradanogrendiklerim/sonradanogrendiklerim.github.io
[eren-github]:  https://github.com/eren/eren.github.io/
[mkdocs]:       https://www.mkdocs.org
[mosh-video]:   https://www.youtube.com/watch?v=8JJ101D3knE
[oh-my-git]:    https://ohmygit.org
[material]:     https://squidfunk.github.io/mkdocs-material/
[sonradan-config]: https://github.com/sonradanogrendiklerim/sonradanogrendiklerim.github.io/blob/src/mkdocs.yaml
[material-start]: https://squidfunk.github.io/mkdocs-material/getting-started/
[github-custom]: https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site
