---
title: Hangi Araçları Kullanıyorum
slug: hangi-araclari-kullaniyorum
description: Geliştirme yaparken hangi araçları kullanıyorum
date: 2025-07-06
categories:
    - Genel
---

Her geliştiricinin kendine özgü bir iş yapış şekli var ve bunları yaparken kendine en uygun araçları
kullanıyor. Geliştirme yaparken başka araçları tanımak, nasıl çalıştığını görmek insanı bir adım
ileri götüren şeylerden. Bir geliştiricide bir araç görüp `neden daha önce bunu kullanmamışım`
dediğim çok noktalar olmuştur. O açıdan bu girdide en çok kullandığım araçları yazmak istedim.

<!-- more -->

## Terminal

Terminal gün içerisinde en çok kullandığım araç. Shell olarak `fish` kullanıyorum ve prompt olarak
da `starship`. Bunların nasıl kurulduğuna ve ayarlandığına uzun uzun
[Terminali Güzelleştirelim][terminali-guzellestirelim] ve
[Fish Terminal Eklentileri][fish-terminal-eklentileri] makalelerinde değinmiştim. Bu makalelere göz
atabilirsiniz.

Fish içerisinde en çok kullandığım eklentiler `z` ve `fzf`. `z` ile dizinler arasında çok rahat
geçiş yapılabiliyor ve `fzf` ile terminal geçmişini arayabiliyorsunuz. Bunların dışında node
sürümlerini yönetmek için `nvm` eklentisini kullanıyorum.

Emülatör olarak [Ghostty][ghostty] tercihim. Minimal ayarlar ile oldukça güzel çalışıyor ve hiç
ayar yapmamanız durumunda bile ön tanımlı olarak iyi görünmekte. Burada sadece font, yazı
seçildiğinde görünecek renk ve uygulama kapandığında eski hali ile açılması için ayarlarım mevcut.

```plain
font-family = MesloLGS NF
font-size = 13
window-save-state = always
window-new-tab-position = end
selection-background = #36383D
selection-foreground = #FDFDFD
```

[terminali-guzellestirelim]: ../../linux/terminali-guzellestirelim.md
[fish-terminal-eklentileri]: ../../linux/fish-terminal-eklentileri.md
[ghostty]: https://ghostty.org

## Terminal Kısayolları

Terminalden konu açılmışken buradan devam edelim. En çok kullandığım komutları birer kısayol (alias)
olarak tanımlamayı tercih ediyorum. Örneğin `git` komutunu yoğun bir şekilde kullanıyorum ve sürekli
olarak başına `git` yazarak kullanmak yerine direkt olarak kısayol olarak tanımlıyorum. Git'in kendi
içerisinde ayar dosyasında kısayol tanımlanabiliyor olsa da yine de `git` komutunu başa yazmak
yerine kısayol kullanmayı tercih ediyorum. Örneğin `st` komutu `git status`, `d` komutu `git diff`
anlamına geliyor. Aynı zamanda `pull` ve `clone` kısayollarım var. Bu kısayolların tamamına
[dotfiles reposundan][dotfiles-git] reposundan erişebilirsiniz. Alias ile başlayan dosyalar
kısayolların tanımlandığı dosyalar.

[dotfiles-git]: https://github.com/eren/dotfiles/blob/main/.config/fish/conf.d/alias.git.fish

## Terminal Uygulamaları

### Tig

Yine terminal ve git ile devam ediyoruz. Git komutlarının yetersiz kaldığı noktada reponun durumunu
öğrenmek için `tig` adlı ncurses tabanlı araç hayat kurtarıcım. Reponun durumunu net bir şekilde
gösterebiliyor ve repo ile bu araç yardımı ile etkileşime geçmek çok daha kolaylaşıyor.

### Ack

Daha yeni bir grep alternatifi. Grep yerine sıklıkla bunu kullanıyorum.

### Bat

`cat` alternatifi. Dosya tipine göre sonucu renklendirebiliyor ve birçok farklı tema desteği var. Bu
tema tercihini sürekli olarak bir parametre ile göndermek gerekiyor. O açıdan `bat` için bir alias
tanımlı. Dotfiles reposundan ulaşabilirsiniz.

### Ydiff

Satır satır diff okumak yerine bazen yan yana diff okumak istiyorsanız `ydiff` aracını
kullanabilirsiniz. Bu araç bende `dw` olarak tanımlı çünkü `d` diff iken `dw` diff word anlamına
geliyor. Ydiff kelime değişikliklerini de gösterebiliyor.

### Ncdu

Sistem içerisinde hangi dizinlerin yer kapladığını görmek için `ncdu` kullanıyorum. Yine ncurses
tabanlı bir konsol aracı ve dizinleri gösterirken aynı zamanda üzerinde silme gibi işlemler
yapabiliyorsunuz.

### Htop

`Htop` muhtemelen hepimizin bildiği bir araç. `top` komutu yerine daha güzel bir biçimde ilgili
verileri görmenizi sağlıyor.

### Iftop

Sunucu üzerinde ne kadar ağ trafiğinin olduğunu gösteren bir araç.

## Editör / IDE

Genel olarak [Cursor][cursor] kullanmaktayım. Konsol üzerinde küçük değişiklikler için `vim / nvim`
kullanıyorum. Ara ara `Sublime Text` de kullandığım editörler arasında. Sublime Text'i daha çok
`TextEdit` muadili olarak kullandığımı söyleyebilirim.

[cursor]: https://cursor.com/

## Spotlight

Bunun için [Alfred][alfred] tercih ettim. [Raycast][raycast] gibi belki daha iyi çalışan
alternatifler olsa da Alfred bütün ihtiyaçlarımı karşılıyor. Açıkçası Raycast kullanmak için
herhangi bir neden görmediğim için geçiş de yapmadım. Siz her ikisini de deneyip karar
verebilirsiniz.

[alfred]: https://www.alfredapp.com
[raycast]: https://www.raycast.com

## Sonuç

Henüz tanımadığım ve hayatımı kolaylaştıracak birçok aracın var olduğuna eminim. Umarım buradaki
araçlar sizlerin hayatını kolaylaştırmaya yardımcı olmuştur. Önereceğiniz bir araç varsa bunu
öğrenmekten mutluluk duyarım. Sadece bir e-posta veya tweet atmanız yeterli. İletişim bilgilerime
[buradan][iletisim] ulaşabilirsiniz.

[iletisim]: https://erenturkay.com/iletisim
