
********************************************************************
  すべての列を出力する
********************************************************************

SELECT *
  FROM Shohin;

 shohin_id |   shohin_mei   | shohin_bunrui | hanbai_tanka | shiire_tanka |  torokubi
-----------+----------------+---------------+--------------+--------------+------------
 0001      | Tシャツ        | 衣服          |         1000 |          500 | 2009-09-20
 0002      | 穴あけパンチ   | 事務用品      |          500 |          320 | 2009-09-11
 0003      | カッターシャツ | 衣服          |         4000 |         2800 |
 0004      | 包丁           | キッチン用品  |         3000 |         2800 | 2009-09-20
 0005      | 圧力鍋         | キッチン用品  |         6800 |         5000 | 2009-01-15
 0006      | フォーク       | キッチン用品  |          500 |              | 2009-09-20
 0007      | おろしがね     | キッチン用品  |          880 |          790 | 2008-04-28
 0008      | ボールペン     | 事務用品      |          100 |              | 2009-11-11
(8 行)

********************************************************************
  ASキーワードで別名を付ける
********************************************************************

SELECT shohin_id AS id,
       shohin_mei AS namae,
       shiire_tanka AS tanka
  FROM Shohin;

********************************************************************
  定数の出力
********************************************************************

SELECT '商品' AS mojiretsu, 38 AS kazu, '2009-02-24' AS hizuke,
       shohin_id, shohin_mei
  FROM Shohin;

 mojiretsu | kazu |   hizuke   | shohin_id |   shohin_mei
-----------+------+------------+-----------+----------------
 商品      |   38 | 2009-02-24 | 0001      | Tシャツ
 商品      |   38 | 2009-02-24 | 0002      | 穴あけパンチ
 商品      |   38 | 2009-02-24 | 0003      | カッターシャツ
 商品      |   38 | 2009-02-24 | 0004      | 包丁
 商品      |   38 | 2009-02-24 | 0005      | 圧力鍋
 商品      |   38 | 2009-02-24 | 0006      | フォーク
 商品      |   38 | 2009-02-24 | 0007      | おろしがね
 商品      |   38 | 2009-02-24 | 0008      | ボールペン
(8 行)

********************************************************************
  結果から重複行を省く
********************************************************************

SELECT DISTINCT　Shohin_bunrui
  FROM Shohin;

 shohin_bunrui
---------------
 衣服
 事務用品
 キッチン用品
(3 行)

SELECT DISTINCT shohin_bunrui, torokubi
  FROM Shohin;

 shohin_bunrui |  torokubi
---------------+------------
 衣服          |
 衣服          | 2009-09-20
 キッチン用品  | 2009-01-15
 事務用品      | 2009-09-11
 キッチン用品  | 2009-09-20
 キッチン用品  | 2008-04-28
 事務用品      | 2009-11-11
(7 行)

********************************************************************
  WHERE句による行の選択
********************************************************************

SELECT shohin_id, torokubi
    FROM Shohin
  WHERE shohin_id = '0001';

 shohin_id |  torokubi
-----------+------------
 0001      | 2009-09-20
(1 行)

********************************************************************
  算術演算子と比較演算子
********************************************************************

SELECT shohin_mei,hanbai_tanka / 2 AS hanbun
    FROM Shohin;

   shohin_mei   | hanbun
----------------+--------
 Tシャツ        |    500
 穴あけパンチ   |    250
 カッターシャツ |   2000
 包丁           |   1500
 圧力鍋         |   3400
 フォーク       |    250
 おろしがね     |    440
 ボールペン     |     50
(8 行)

SELECT shohin_mei, hanbai_tanka
    FROM Shohin
  WHERE hanbai_tanka > 1000;

   shohin_mei   | hanbai_tanka
----------------+--------------
 カッターシャツ |         4000
 包丁           |         3000
 圧力鍋         |         6800
(3 行)

********************************************************************
  論理演算子
********************************************************************

SELECT shohin_mei, hanbai_tanka
    FROM Shohin
  WHERE NOT hanbai_tanka >= 1000;  ※販売単価が1,000円以上ではない=1000円以下

  shohin_mei  | hanbai_tanka
--------------+--------------
 穴あけパンチ |          500
 フォーク     |          500
 おろしがね   |          880
 ボールペン   |          100
(4 行)

SELECT shohin_mei,shohin_bunrui, hanbai_tanka
    FROM Shohin
  WHERE shohin_bunrui = 'キッチン用品'
    AND hanbai_tanka > 1000; 

 shohin_mei | shohin_bunrui | hanbai_tanka
------------+---------------+--------------
 包丁       | キッチン用品  |         3000
 圧力鍋     | キッチン用品  |         6800
(2 行)


上の条件式をOR条件にすると・・・

   shohin_mei   | shohin_bunrui | hanbai_tanka
----------------+---------------+--------------
 カッターシャツ | 衣服          |         4000
 包丁           | キッチン用品  |         3000
 圧力鍋         | キッチン用品  |         6800
 フォーク       | キッチン用品  |          500
 おろしがね     | キッチン用品  |          880
(5 行)

AND条件にすると・・・

SELECT shohin_bunrui,hanbai_tanka
    FROM Shohin
  WHERE shohin_bunrui = '衣服'
  AND shohin_bunrui = 'キッチン用品';

 shohin_bunrui | hanbai_tanka
---------------+--------------
(0 行)

OR条件にすると・・・

SELECT shohin_bunrui,hanbai_tanka
    FROM Shohin
  WHERE shohin_bunrui = '衣服'
  OR shohin_bunrui = 'キッチン用品';

 shohin_bunrui | hanbai_tanka
---------------+--------------
 衣服          |         1000
 衣服          |         4000
 キッチン用品  |         3000
 キッチン用品  |         6800
 キッチン用品  |          500
 キッチン用品  |          880
(6 行)

AND条件はOR条件より優先されてしまうため、登録日が '2009-09-20'のものが全て抽出されてしまう
なので、OR条件を優先させるときは半角カッコ（）で括る

SELECT shohin_mei, shohin_bunrui, torokubi
  FROM Shohin
 WHERE shohin_bunrui = '事務用品'
   AND ( torokubi = '2009-09-11'
      OR torokubi = '2009-09-20');