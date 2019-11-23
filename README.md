# 地震震度計算
以地震觀測資料計算出中央氣象局（CWB）、日本氣象廳（JMA）、福建省地震局（FJEA）所使用的震度。

## 準備步驟
1. 安裝 [GNU Octave](https://www.gnu.org/software/octave/)（計算程式適用於 5.1.0 Windows-64 版）。
2. 下載所有檔案，並另外下載觀測資料，觀測資料需包括三軸加速度訊號（單位為 gal）及取樣率（單位為 Hz），把所有檔案放在同一目錄。
3. 開啟 GNU Octave，切換到檔案所在的目錄。

## 計算
計算程式皆為函數（function），呼叫格式為`函數名稱(觀測資料檔案名稱,分隔符號,要忽略的列數,南北向行的位置,東西向行的位置,上下向行的位置,取樣率)`，`cwb2000`無取樣率參數。`cwb2020`輸出為字串，其餘輸出為數值。
* `cwb2000`對應的震度為中央氣象局於2000年8月1日公告修訂的震度，分為0級至7級。
* `cwb2020`對應的震度為中央氣象局預計於2020年1月1日開始採用的震度，分為0級、1級、2級、3級、4級、5弱、5強、6弱、6強、7級。
* `jma`對應的震度為日本氣象廳的計測震度，帶有一位小數，程式碼修改自[Rで計測震度の算出](http://statrstart.github.io/2015/04/19/R%E3%81%A7%E8%A8%88%E6%B8%AC%E9%9C%87%E5%BA%A6%E3%81%AE%E7%AE%97%E5%87%BA/)。
* `fjea`對應的震度為福建省地震局的地震儀器烈度，分為1度至12度，程式碼修改自[Rで計測震度の算出](http://statrstart.github.io/2015/04/19/R%E3%81%A7%E8%A8%88%E6%B8%AC%E9%9C%87%E5%BA%A6%E3%81%AE%E7%AE%97%E5%87%BA/)。

另有震度轉換程式（亦為函數），呼叫格式為`intensity_scale(震度種類,震度數值)`，輸出為字串。
* `intensity_scale`是將日本氣象廳的計測震度轉換為震度階級，日本氣象廳震度階級分為0、1、2、3、4、5弱（5 Lower）、5強（5 Upper）、6弱（6 Lower）、6強（6 Upper）、7。

## 範例
地震觀測資料來源：中央氣象局 [個案地震報導](https://scweb.cwb.gov.tw/zh-tw/page/disaster/3)、日本氣象廳 [強震観測データ](https://www.data.jma.go.jp/svd/eqev/data/kyoshin/jishin/index.html)。

以[中央氣象局的檔案](https://scweb.cwb.gov.tw/special/19990921/ASCIIfile/T073001.263.txt)為例，可使用下列方式計算出震度（jma 可更改為 fjea、cwb2020）

```octave
>> cwb2000("T073001.263.txt","",11,3,4,2)
ans =  6
>> jma("T073001.263.txt","",11,3,4,2,200)
ans =  5.2000
```

以[日本氣象廳的檔案](https://www.data.jma.go.jp/svd/eqev/data/kyoshin/jishin/001006_tottori-seibu/dat/AA06EA01.csv)為例，可使用下列方式計算出震度（jma 可更改為 fjea、cwb2020）

```octave
>> cwb2000("AA06EA01.csv",",",7,1,2,3)
ans =  6
>> jma("AA06EA01.csv",",",7,1,2,3,100)
ans =  5.1000
```

以日本氣象廳的計測震度為例，可使用下列方式轉換為震度階級

```octave
>> intensity_scale("jma",5.1)
ans = 5 Upper
```

## 聲明
程式計算、轉換的方式與官方實際做法有所差異，得出的結果僅供參考，實際震度應以官方發布的為準。`jma`計算出的數值與日本氣象廳公布的計測震度可能有0.1的誤差。`fjea`沒有福建省地震局的資料可供驗證，誤差大小未知。

## 授權條款
本 repository 採用 [MIT 授權條款](https://github.com/chemars/Seismic-Intensity-Scales/blob/master/LICENSE)。  
[Rで計測震度の算出](http://statrstart.github.io/2015/04/19/R%E3%81%A7%E8%A8%88%E6%B8%AC%E9%9C%87%E5%BA%A6%E3%81%AE%E7%AE%97%E5%87%BA/)內的程式碼的授權條款為 CC0，[相關說明](https://github.com/statrstart/statrstart.github.io/issues/1)。

## 參考資料
* [Rで計測震度の算出](http://statrstart.github.io/2015/04/19/R%E3%81%A7%E8%A8%88%E6%B8%AC%E9%9C%87%E5%BA%A6%E3%81%AE%E7%AE%97%E5%87%BA/)，[GitHub repository](https://github.com/statrstart/statrstart.github.io)
* [交通部中央氣象局有感地震報告發布作業要點](https://www.cwb.gov.tw/Data/service/notice/download/notice_20141231104524.pdf)
* [計測震度の算出方法](https://www.data.jma.go.jp/svd/eqev/data/kyoshin/kaisetsu/calc_sindo.htm)
* [気象庁震度階級の解説](https://www.jma.go.jp/jma/kishou/know/shindo/jma-shindo-kaisetsu-pub.pdf)
* [地震仪器烈度表](http://www.fjdspm.com/dzzt/zcfgzt/2013-03-14/231.html)
