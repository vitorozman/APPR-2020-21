# Analiza podatkov s programom R, 2020/21

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2020/21

* [![Shiny](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/vitorozman/APPR-2020-21/master?urlpath=shiny/APPR-2020-21/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/vitorozman/APPR-2020-21/master?urlpath=rstudio) RStudio


## **Analiza najbogatejših ljudi na svetu v letu 2020**


### **STRUKTURA**

>Analiza o njbogatejših ljudi bo temeljila na štirih vejah. Vsaka veja vsebuje skupno značilnost na kateri bo narejena analiza. Glavne veje sem poimenoval **BIO**, **GEO**, **PANG** in **TOP5** (opisane spodaj). Uradna stran, ki rangira najbogatejše ljudi se nahaja na spletnem portalu [Forbes Billionaires 2020](https://www.forbes.com/billionaires/). Podatke, ki so v json formatu, pa sem dobil na povezavah pod VIRI.

---

#### BIO
Analiza glede na biološke značilnosti kot sta, spol in starost

* Prikazal bom delž moških in žensk
  * ideja: prikazan delež M in Ž v obliki tortnega diagrama

* Prikaz povprečnega premoženja glede na starost
  * ideja: stolpični diagram (povprečno premoženje/starost)

* Izstopajoči odmiki od povprečja
  * ideja: tabela (spol/ekstremi)

#### GEO
Analiza glede geografsko lego bivanja

* Za posamezno državo bom analizeral število oseb, skupno premoženje vseh oseb in najbogatejšega iz med njih
  * ideja: zemljevidni prikaz sveta, kjer so vidne posamezne države in spremenljivke

#### PANG
Analiza glede na panogo

* Prikaz posamezne panoge in izstopajoči podatki od povprečja
  * ideja: diagram (povprečno premoženje/panoga) in točkovno ozančeni ekstremi (max in min premoženje v panogi)

#### TOP5
Analiza pet najbogatejših ljudi v letu 2020

* Prikaz rasti premoženja
  * ideja: diagram (premoženje/leto)
  
* Anliza posamezne osebe in rangiranje v preteklih obdobjih
  * ideja: tabela(za vsako leto prvi trije v obdobju + mesto njabogatejših pet iz leta 2020 in njihova sprememba premoženja)
  * ideja: prikaz povprečne, maksimalna in minimalna rasti

---


#### **Datoteke se nahajajo v mapi podatki:**

* billionaires20.json
* billionaires19.json
* billionaires18.json
* billionaires17.json
* billionaires16.json
* billionaires15.json


### **VIRI**
Lestvica najbogatejših ljudi za leto:

* [2020](https://www.forbes.com/forbesapi/person/billionaires/2020/position/true.json) (json format)
* [2019](https://www.forbes.com/forbesapi/person/billionaires/2019/position/true.json) (json format) 
* [2018](https://www.forbes.com/forbesapi/person/billionaires/2018/position/true.json) (json format) 
* [2017](https://www.forbes.com/forbesapi/person/billionaires/2017/position/true.json) (json format) 
* [2016](https://www.forbes.com/forbesapi/person/billionaires/2016/position/true.json) (json format) 
* [2015](https://www.forbes.com/forbesapi/person/billionaires/2015/position/true.json) (json format) 

Zemljevid sveta:

* [zemljevid]() v pripravi

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `rgdal` - za uvoz zemljevidov
* `rgeos` - za podporo zemljevidom
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `tidyr` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `mosaic` - za pretvorbo zemljevidov v obliko za risanje z `ggplot2`
* `maptools` - za delo z zemljevidi
* `tmap` - za izrisovanje zemljevidov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

## Binder

Zgornje [povezave](#analiza-podatkov-s-programom-r-202021)
omogočajo poganjanje projekta na spletu z orodjem [Binder](https://mybinder.org/).
V ta namen je bila pripravljena slika za [Docker](https://www.docker.com/),
ki vsebuje večino paketov, ki jih boste potrebovali za svoj projekt.

Če se izkaže, da katerega od paketov, ki ji potrebujete, ni v sliki,
lahko za sprotno namestitev poskrbite tako,
da jih v datoteki [`install.R`](install.R) namestite z ukazom `install.packages`.
Te datoteke (ali ukaza `install.packages`) **ne vključujte** v svoj program -
gre samo za navodilo za Binder, katere pakete naj namesti pred poganjanjem vašega projekta.

Tako nameščanje paketov se bo izvedlo pred vsakim poganjanjem v Binderju.
Če se izkaže, da je to preveč zamudno,
lahko pripravite [lastno sliko](https://github.com/jaanos/APPR-docker) z želenimi paketi.

Če želite v Binderju delati z git,
v datoteki `gitconfig` nastavite svoje ime in priimek ter e-poštni naslov
(odkomentirajte vzorec in zamenjajte s svojimi podatki) -
ob naslednjem zagonu bo mogoče delati commite.
Te podatke lahko nastavite tudi z `git config --global` v konzoli
(vendar bodo veljale le v trenutni seji).
