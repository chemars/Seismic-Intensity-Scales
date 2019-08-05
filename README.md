# 地震震度計算
以地震觀測資料計算出中央氣象局（CWB）、日本氣象廳（JMA）、福建省地震局（FJEA）所使用的震度。

## 準備步驟
1. 安裝 [GNU Octave](https://www.gnu.org/software/octave/)。
2. 下載所有檔案，並另外下載觀測資料，資料需包括三軸加速度訊號（單位為gal）及取樣率，把所有檔案放在同一目錄。
3. 開啟 GNU Octave，切換到檔案所在的目錄。

## 計算與轉換
計算程式皆為函數（function），呼叫格式為`函數名稱(觀測資料檔案名稱,分隔符號,要忽略的行數,南北向列的位置,東西向列的位置,上下向列的位置,取樣率)`，`cwb2000`無取樣率參數，輸出皆為數值。

* `cwb2000`對應的震度為中央氣象局於2000年8月1日公告修訂的震度，分為0至7級。

* `cwb2020`對應的震度為中央氣象局於2019年調整的震度，尚未公布與實施。

* `jma`對應的震度為日本氣象廳的計測震度，帶有一位小數，程式碼修改自[Rで計測震度の算出](http://statrstart.github.io/2015/04/19/R%E3%81%A7%E8%A8%88%E6%B8%AC%E9%9C%87%E5%BA%A6%E3%81%AE%E7%AE%97%E5%87%BA/)。

* `fjea`對應的震度為福建省地震局的地震儀器烈度，分為1至12度，程式碼修改自[Rで計測震度の算出](http://statrstart.github.io/2015/04/19/R%E3%81%A7%E8%A8%88%E6%B8%AC%E9%9C%87%E5%BA%A6%E3%81%AE%E7%AE%97%E5%87%BA/)。

轉換程式亦為函數，呼叫格式為`intensity_scale(震度種類,震度數值)`，輸出為字串。

* `intensity_scale`是將日本氣象廳的計測震度轉換為震度階級，分為0、1、2、3、4、5弱（5 Lower）、5強（5 Upper）、6弱（6 Lower）、6強（6 Upper）、7。

## 範例
地震觀測資料來源：中央氣象局 [個案地震報導](https://scweb.cwb.gov.tw/zh-tw/page/disaster/3)、日本氣象廳 [主な地震の強震観測データ](http://www.data.jma.go.jp/svd/eqev/data/kyoshin/jishin/index.html)。

以[中央氣象局的檔案](https://scweb.cwb.gov.tw/special/19990921/ASCIIfile/T073001.263.txt)而言，可使用下列方式計算出震度（jma可更改為fjea、cwb2020）

```octave
>> cwb2000("T073001.263.txt","",11,3,4,2)
ans =  6
>> jma("T073001.263.txt","",11,3,4,2,200)
ans = 5.2000
```

以[日本氣象廳的檔案](http://www.data.jma.go.jp/svd/eqev/data/kyoshin/jishin/001006_tottori-seibu/dat/AA06EA01.csv)而言，可使用下列方式計算出震度（jma可更改為fjea、cwb2020）

```octave
>> cwb2000("AA06EA01.csv",",",7,1,2,3)
ans =  6
>> jma("AA06EA01.csv",",",7,1,2,3,100)
ans = 5.1000
```

以日本氣象廳的計測震度而言，可使用下列方式轉換為震度階級

```octave
>> intensity_scale("jma",5.1)
ans =  5 Upper
```

## 聲明
程式計算、轉換的方式與官方實際做法有所差異，得出的結果僅供參考。`cwb2000.m`是依據加速度所在區間計算震度，未使用震度與加速度的[關係式](https://scweb.cwb.gov.tw/zh-TW/Guidance/FAQdetail/37)。`jma.m`計算出的數值與日本氣象廳公布的計測震度可能有0.1的誤差。`fjea.m`沒有福建省地震局的資料可供驗證，誤差大小未知。`cwb2020.m`是依據中央氣象局的草案計算震度，程式尚未公開。

## 授權條款
本倉庫採用 [MIT 授權條款](https://github.com/chemars/Seismic-Intensity-Scales/blob/master/LICENSE)。

[Rで計測震度の算出](http://statrstart.github.io/2015/04/19/R%E3%81%A7%E8%A8%88%E6%B8%AC%E9%9C%87%E5%BA%A6%E3%81%AE%E7%AE%97%E5%87%BA/)內的程式碼的授權條款為CC0，[相關說明](https://github.com/statrstart/statrstart.github.io/issues/1)。

## 參考資料
* [Rで計測震度の算出](http://statrstart.github.io/2015/04/19/R%E3%81%A7%E8%A8%88%E6%B8%AC%E9%9C%87%E5%BA%A6%E3%81%AE%E7%AE%97%E5%87%BA/)，[GitHub repository](https://github.com/statrstart/statrstart.github.io)
* [交通部中央氣象局地震震度分級表](https://www.cwb.gov.tw/Data/service/notice/download/notice_20141231104524.pdf)
* [計測震度の算出方法](http://www.data.jma.go.jp/svd/eqev/data/kyoshin/kaisetsu/calc_sindo.htm)
* [地震仪器烈度表](http://www.fjdspm.com/dzzt/zcfgzt/2013-03-14/231.html)
