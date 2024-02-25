# Sonradan Öğrendiklerim

## Proje Yapısı

Statik olarak GitHub Pages kullanılıyor. `src/` branch'i `mkdocs` dosyalarını, `main` branch statik
olarak oluşturulmuş dosyaları barındırıyor.

## Deploy

`src/` branchine commit edildikten sonra `make deploy` komutu `gh-pages` branchi oluşturarak
otomatik olarak `main` branch'e commit ediyor. MkDocs belgelerinde yazdığı gibi PR oluşturmuyor,
direkt olarak oluşan dosyaları commit ediyoruz.
