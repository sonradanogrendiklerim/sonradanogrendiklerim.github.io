---
title: "Yeni Nesil Python Paket Yöneticisi: uv"
slug: yeni-nesil-python-paket-yoneticisi-uv
description: Pip, pipx, poetry alternatifi hızlı paket yöneticisi
date: 2024-08-25
categories:
    - Python
---

Bir Python projesinin olmazsa olmazı paket yöneticisidir. Bunun en bilineni
[pip][pip]{:target="_blank"} olmakla birlikte paket yöneticileri sadece bununla sınırlı değil.
[pipx][pipx]{:target="_blank"}, [poetry][poetry]{:target="_blank"} gibi projeler de farklı
ihtiyaçları karşılamak için ortaya çıkmışlar. Ancak bunların arasında bir tanesi var ki çok hızlı
çalışıyor ve kullanması oldukça zevkli: [uv][uv].

[pip]:      https://pip.pypa.io/en/stable/
[pipx]:     https://pipx.pypa.io/stable/
[poetry]:   https://python-poetry.org
[uv]:       https://github.com/astral-sh/uv

<!-- more -->

Uv'nin her özelliğini kullandığımı söyleyemem. Daha çok pip ve venv özelliklerini kullanıyorum ve
bunları tanıtmak istedim. Paket yüklemek ve güncellemek gerçekten hızlı ve tek yapmanız gereken pip
komutlarının önüne `uv` eklemeniz.

## Uv Yükleme

Kullandığınız işletim sistemine bağlı olarak yükleme yöntemi değişiklik gösterecektir. MacOS kullanıyorsanız homebrew ile `brew install uv` komutu ile yükleyebilirsiniz. Linux altında iseniz aşağıdaki komut ile yükleyebilirsiniz.

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## Yeni Sanal Ortam Oluşturma

```sh
uv venv
```

Şu anki Python ile `.venv` dizininde bir sanal ortam oluşturacaktır. Devamında
`source .venv/bin/activate` ile bunu etkinleştirebilirsiniz. Benim gibi
[fish][fish]{:target="_blank"} kullanıyorsanız bunun yerine `source .venv/bin/activate.fish` komutunu kullanmanız gerekmekte. Uv hangi kabuğu kullandığınızı anlayarak gerekli komutu yazmakta.

Eğer spesifik bir Python sürümü ile sanal ortam oluşturmak istiyorsanız `-p` parametresini
kullanmanız yeterli. `uv venv -p PYTHON-SURUMU`  komutu ile bunu başarabilirsiniz.

[fish]: https://fishshell.com

## Paket Yükleme

```sh
uv pip install PAKETISMI
```

`pip` ile geriye uyumlu şekilde çalışıyor, en güzel özelliği de bu. Herhangi bir `pip` komutunun
önüne `uv` ekleyerek istediğimiz sonucu elde edebiliyoruz. Örneğin `requirements.txt` dosyasından paketleri yüklemek istediğimizde aşağıdaki komutu çalıştırmamız yeterli.

```sh
uv pip install -r requirements.txt
```

## Python Versiyonlarını Görme / Yükleme

```sh
uv python list
```

Komutu ile hangi Python versiyonlarının yüklenmiş ve kullanılabilir olduğunu görebiliyoruz. Eğer
sistemimizde olmayan bir sürümü yüklemek istersek aşağıdaki komutu kullanmamız yeterli olacaktır.

```sh
uv python install SURUM
```

Sonrasında venv oluştururken hangi python sürümünü kullanacağımızı belirtmemiz yeterli. Yukarıda
bahsettiğim gibi `uv venv -p SURUM` komutu ile bunu başarabiliyoruz.

## Yeni Proje Başlatma

```sh
uv init
```

İçinde bulunduğunuz dizin içerisinde `pyproject.toml` ve minimal bir dizin yapısını oluşturur.
`pypyroject.toml` yönetimi için `uv add` ve `uv remove` komutlarını kullanabiliyoruz. Bu komutlar
projeye paket ekliyor veya çıkarıyor.

##  Sonuç

Etrafta birçok venv ve paket yöneticisi var ancak uv aralarında en hızlı çalışanı. Uv kullanmaya
başladığımdan beri paket yüklemek ve çıkarmak çok daha hızlı olmaya başladı ve kullanması oldukça
keyifli.

Tabii ki kullanmadığım birçok özelliği var. Bu özelliklere
[uv belgelerinden][uv-docs]{:target="_blank"} ulaşabilirsiniz.

[uv-docs]: https://docs.astral.sh/uv/
