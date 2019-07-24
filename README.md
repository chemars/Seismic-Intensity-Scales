# 地震震度計算
以地震觀測資料計算出中央氣象局（CWB）、日本氣象廳（JMA）、福建省地震局（FJEA）所使用的震度，可於 GNU Octave 執行。

## 說明
### 計算
`cwb2000.m`對應的震度為中央氣象局於2000年8月1日公告修訂的震度，分為0至7級。

`cwb2020.m`對應的震度為中央氣象局於2019年調整的震度，尚未正式公布與實施。

`jma.m`對應的震度為日本氣象廳的計測震度，帶有一位小數，程式碼修改自[Rで計測震度の算出](http://statrstart.github.io/2015/04/19/R%E3%81%A7%E8%A8%88%E6%B8%AC%E9%9C%87%E5%BA%A6%E3%81%AE%E7%AE%97%E5%87%BA/)（原本為R語言）。

`fjea.m`對應的震度為福建省地震局的地震儀器烈度，分為1至12度，程式碼修改自[Rで計測震度の算出](http://statrstart.github.io/2015/04/19/R%E3%81%A7%E8%A8%88%E6%B8%AC%E9%9C%87%E5%BA%A6%E3%81%AE%E7%AE%97%E5%87%BA/)（原本為R語言）。

以上程式皆為函數（function），呼叫格式為`函數名稱(檔案名稱,分隔符號,要忽略的行數,南北向列的位置,東西向列的位置,上下向列的位置,取樣率)`，`cwb2000.m`無取樣率參數，輸出皆為數值。

### 轉換
`scale.m`是將日本氣象廳的計測震度轉換為震度階級，分為0、1、2、3、4、5弱、5強、6弱、6強、7。

上述程式亦為函數，呼叫格式為`scale(震度種類,震度數值)`，輸出為字串。

## 範例
以[中央氣象局的檔案](https://scweb.cwb.gov.tw/special/19990921/ASCIIfile/T073001.263.txt)而言，可使用下列方式計算出震度

`cwb2000("T073001.263.txt","",11,3,4,2)`、`jma("T073001.263.txt","",11,3,4,2,200)`，jma可更改為fjea

以[日本氣象廳的檔案](http://www.data.jma.go.jp/svd/eqev/data/kyoshin/jishin/001006_tottori-seibu/dat/AA06EA01.csv)而言，可使用下列方式計算出震度

`cwb2000("AA06EA01.csv",",",7,1,2,3)`、`jma("AA06EA01.csv",",",7,1,2,3,100)`，jma可更改為fjea

以日本氣象廳的計測震度而言，可使用下列方式轉換為震度階級

`scale("jma",5.1)`

## 聲明
程式計算、轉換的方式與官方實際做法有所差異，得出的結果僅供參考。`cwb2000.m`是依據加速度所在區間計算震度，未使用震度與加速度的[關係式](https://scweb.cwb.gov.tw/zh-TW/Guidance/FAQdetail/37)。`jma.m`計算出的數值與日本氣象廳公布的計測震度可能有0.1的誤差。`fjea.m`沒有福建省地震局的資料可供驗證，誤差大小未知。

`cwb2020.m`是依據中央氣象局的草案計算震度，程式尚不完整，尚待中央氣象局正式公告後修正。

## 參考資料
* [Rで計測震度の算出](http://statrstart.github.io/2015/04/19/R%E3%81%A7%E8%A8%88%E6%B8%AC%E9%9C%87%E5%BA%A6%E3%81%AE%E7%AE%97%E5%87%BA/)，[GitHub repository](https://github.com/statrstart/statrstart.github.io)
* [交通部中央氣象局地震震度分級表](https://www.cwb.gov.tw/Data/service/notice/download/notice_20141231104524.pdf)
* [計測震度の算出方法](http://www.data.jma.go.jp/svd/eqev/data/kyoshin/kaisetsu/calc_sindo.htm)
* [地震仪器烈度表](http://www.fjdspm.com/dzzt/zcfgzt/2013-03-14/231.html)
* 觀測資料：[個案地震報導](https://scweb.cwb.gov.tw/zh-tw/page/disaster/3)、[主な地震の強震観測データ](http://www.data.jma.go.jp/svd/eqev/data/kyoshin/jishin/index.html)
