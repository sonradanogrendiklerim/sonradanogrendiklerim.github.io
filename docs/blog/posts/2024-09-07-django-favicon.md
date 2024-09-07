---
title: Django ile Favicon Dosyası Sunmak
slug: django-ile-favicon-dosyasi-sunmak
description: Statik bir adreste favicon dosyası nasıl sunulur.
date: 2024-09-07
categories:
    - Python
---

Favicon dosyasına hepimiz aşinayız. Tarayıcı sekmesinde bir web sayfasının ikonu olarak kendini
göstermekte ve arama motorları tarafından indexlenmekte. Ancak burada bir problem karşımıza çıktı ki
CDN ile favicon dosyasını sunmak arama motorlarında favicon dosyasının görünmemesine sebep oldu.
Bunun nedeni favicon adresinin CDN kullanımından dolayı sürekli değişmesi. Bu yazıda statik bir
adreste favicon dosyasının nasıl sunulacağına değineceğim.

<!-- more -->

## Sürüme Bağlı Statik Dosyalar

Eğer üzerinde çalıştığınız projede her sürümde `STATIC_ROOT` ve `STATIC_URL` değişiyorsa bu yazıyı
okumaya devam edebilirsiniz. Problemin temeli uygulamanın her sürümünde favicon adresinin
`/static/UYGULAMA-SURUMU/favicon.png` şeklinde olmasından kaynaklanıyor. Durum böyle olunca Google
arama sonucunda favicon dosyasını göstermeyebiliyor. Çözümü favicon dosyasını statik bir adreste
sunmak. Bunun için `urls.py` ve `views.py` içerisinde ufak değişiklikler yapmak gerekli.

## Statik Olarak Favicon Sunmak

Uygulamanızın `urls.py` içerisine aşağıdaki satırı ekleyin.

```python
from .views import serve_favicon


urlpatterns = [
    # ...
    path("favicon.png", serve_favicon, name="serve_favicon"),
]
```

`views.py` içerisine favicon dosyasını okuyup sunacak satırları ekleyin.

```python
import os

from django.http import Http404
from django.http.response import FileResponse

from my_project.settings import STATIC_ROOT


def serve_favicon(request):
    favicon_file = os.path.join(STATIC_ROOT, "img/favicon.png")

    try:
        return FileResponse(open(favicon_file, "rb"))
    except IOError:
        raise Http404
```

Devamında favicon dosyasını içeren HTML satırlarını direkt olarak `/favicon.png` kullanacak şekilde
değiştirin. Bu genelde `base.html` içerisinde yer almakta. Burada `static("img/favicon.png")`
kullanmadığımıza dikkatinizi çekmek isterim. Dosya adresinin statik olarak `/favicon.png` olması
gerekmekte.

## Sonuç

Sadece tek bir dosya için CDN nimetlerinden faydalanamadığımızın farkındayım ancak sürüme bağlı
statik dosya adreslerinin değiştiği durumda bunun başka bir çözümü yok. Tek bir dosyayı okuyup
sunmak da o kadar performans problemine neden olmayacaktır.

Umarım bu yazı sizlere faydalı olmuştur.
