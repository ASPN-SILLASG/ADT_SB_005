@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 월 수불부'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZSB_R_0005 
  with parameters
    @EndUserText.label: '시작년월'
    sspmon : char6,
    @EndUserText.label: '종료년월'
    espmon : char6
  as select from    zassbt0000     as _sb
    join            I_Product      as _mara on _sb.matnr = _mara.Product
    left outer join ZSB_I_0005_01 as _ab   on  _ab.spmon = $parameters.sspmon
                                            and _ab.matnr = _sb.matnr
    left outer join ZSB_I_0005_02 as _ed   on  _ed.spmon = $parameters.espmon
                                            and _ed.matnr = _sb.matnr
  //  association [0..1] to zassbt0000              as _ab    on  _ab.spmon = $parameters.sspmon
  //                                                          and _ab.kalnr = _sb.kalnr
  //  association [0..1] to zassbt0000              as _ed    on  _ed.spmon = $parameters.espmon
  //                                                          and _ed.kalnr = _sb.kalnr
  association [0..1] to I_Prodvaluationclasstxt as _Bkl   on  $projection.Bklas = _Bkl.ValuationClass
                                                          and _Bkl.Language     = '3'
  association [0..1] to I_ProductText           as _makt  on  _sb.matnr      = _makt.Product
                                                          and _makt.Language = '3'
  association [0..1] to I_ExtProdGrpText        as _Epg   on  $projection.Extwg = _Epg.ExternalProductGroup
                                                          and _Epg.Language     = '3'
  association [0..1] to I_ProductGroupText_2    as _Matkl on  $projection.Matkl = _Matkl.ProductGroup
                                                          and _Matkl.Language   = '3'
//  association [0..1] to ZR_ASSB_CM00              as _Maker on  _Maker.Zservice = 'MakerBrand'
//                                                          and _Maker.Zcode    = _mara.YY1_MAT_MAKER_PRD
//  association [0..1] to ZR_ASSB_CM00              as _Mcat  on  _Mcat.Zservice = 'ProductCategory'
//                                                          and _Mcat.Zcode    = _mara.YY1_PROD_RANGE_PRD

{
      @EndUserText.label: '조회년월'
      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: [{ position: 140 }]
  key cast( '000000' as abap.numc(6))                                   as Spmon,

      @EndUserText.label: '플랜트'
      @Consumption.filter: { mandatory: true }
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_PLANT_01', element: 'Plant' } }]
      @UI.selectionField: [{ position: 20 }]
      @UI.lineItem: [{ position: 10 }]
  key _sb.bwkey                                                         as Bwkey,

      @EndUserText.label: '자재'
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_PRODUCT_01', element: 'Product' } }]
      @UI.selectionField: [{ position: 40 }]
      @UI.lineItem: [{ position: 50, label: '자재번호' }]
  key _sb.matnr                                                         as Matnr,

      @EndUserText.label: '자재명'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 40 }]
      _makt.ProductName                                                 as maktx,

      @EndUserText.label: '평가클래스'
      @Consumption.filter: { mandatory: true }
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_VCLASS_01', element: 'ValuationClass' } }]
      @UI.selectionField: [{ position: 30 }]
      @UI.lineItem: [{ position: 150 }]
      _sb.bklas                                                         as Bklas,

      @EndUserText.label: '평가클래스명'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 20 }]
      _Bkl.ValuationClassDescription                                    as Bklast,

      @EndUserText.label: '분류1'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 80 }]
      _mara.ExternalProductGroup                                        as Extwg,

      @EndUserText.label: '분류1명'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 90 }]
      _Epg.ExternalProductGroupName                                     as Extwgt,

      @EndUserText.label: '분류2'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 60 }]
      _mara.ProductGroup                                                as Matkl,

      @EndUserText.label: '분류2명'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 70 }]
      _Matkl.ProductGroupText                                           as Matklt,

//      @EndUserText.label: '브랜드/메이커'
//      @Consumption.filter.hidden: true
//      @UI.lineItem: [{ position: 100 }]
//      _mara.YY1_MAT_MAKER_PRD                                           as Maker,

//      @EndUserText.label: '브랜드/메이커명'
//      @Consumption.filter.hidden: true
//      @UI.lineItem: [{ position: 110 }]
//      _Mcat.Ztext                                                       as YY1_MAT_MAKER_PRDT,
//
//      @EndUserText.label: '제품군'
//      @Consumption.filter.hidden: true
//      @UI.lineItem: [{ position: 120 }]
//      @ObjectModel.text.element: ['YY1_PROD_RANGE_PRDT']
//      _mara.YY1_PROD_RANGE_PRD                                          as Prange,
//
//      @EndUserText.label: '제품군명'
//      @Consumption.filter.hidden: true
//      @UI.lineItem: [{ position: 130 }]
//      _Maker.Ztext                                                      as YY1_PROD_RANGE_PRDT,
//
//      @EndUserText.label: '재종'
//      @Consumption.filter.hidden: true
//      @UI.lineItem: [{ position: 30 }]
//      _mara.YY1_MAT_JJ_PRD                                              as Mat_JJ,
//
//      @EndUserText.label: '제품 구분'
//      @Consumption.filter.hidden: true
//      @UI.lineItem: [{ position: 180, label: 'P/NP' }]
//      _mara.YY1_MAT_PNP_PRD                                             as PNP,

      @EndUserText.label: '단위'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 160 }]
      _sb.meins                                                         as Meins,

      @EndUserText.label: '통화'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 170 }]
      _sb.waers                                                         as Waers,

      @EndUserText.label: '기초수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 180 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      _ab.f000m                                                         as f000m,

      @EndUserText.label: '기초금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 190 }]
      @Aggregation.default: #SUM
      _ab.f000a                                                         as f000a,

      @EndUserText.label: '기초단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 200 }]
      _ab.f000d                                                         as f000d,

      @EndUserText.label: '구매입고수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 210 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f001m)                                                    as f001m,

      @EndUserText.label: '구매입고금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 220 }]
      @Aggregation.default: #SUM
      sum(_sb.f001a)                                                    as f001a,

      @EndUserText.label: '구매입고단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 230 }]
      cast( case when sum(_sb.f001m) = 0 or sum(_sb.f001a) = 0 then 0
            else sum(_sb.f001a) / sum(_sb.f001m) end as abap.dec(20,0)) as f001d,

      @EndUserText.label: '생산입고수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 240 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f002m)                                                    as f002m,

      @EndUserText.label: '생산입고금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 250 }]
      @Aggregation.default: #SUM
      sum(_sb.f002a)                                                    as f002a,

      @EndUserText.label: '생산입고단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 260 }]
      cast( case when sum(_sb.f002m) = 0 or sum(_sb.f002a) = 0 then 0
            else sum(_sb.f002a) / sum(_sb.f002m) end as abap.dec(20,0)) as f002d,

      @EndUserText.label: '기타입고수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 270 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f003m)                                                    as f003m,

      @EndUserText.label: '기타입고금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 280 }]
      @Aggregation.default: #SUM
      sum(_sb.f003a)                                                    as f003a,

      @EndUserText.label: '기타입고단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 290 }]
      cast( case when sum(_sb.f003m) = 0 or sum(_sb.f003a) = 0 then 0
            else sum(_sb.f003a) / sum(_sb.f003m) end as abap.dec(20,0)) as f003d,

      @EndUserText.label: '창고이동입고수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 300 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f004m)                                                    as f004m,

      @EndUserText.label: '창고이동입고금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 310 }]
      @Aggregation.default: #SUM
      sum(_sb.f004a)                                                    as f004a,

      @EndUserText.label: '창고이동입고단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 320 }]
      cast( case when sum(_sb.f004m) = 0 or sum(_sb.f004a) = 0 then 0
            else sum(_sb.f004a) / sum(_sb.f004m) end as abap.dec(20,0)) as f004d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 330 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f005m)                                                    as f005m,

      @Consumption.filter.hidden: true
      @Aggregation.default: #SUM
      @UI.lineItem: [{ position: 340 }]
      sum(_sb.f005a)                                                    as f005a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 350 }]
      cast( case when sum(_sb.f005m) = 0 or sum(_sb.f005a) = 0 then 0
            else sum(_sb.f005a) / sum(_sb.f005m) end as abap.dec(20,0)) as f005d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 360 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f006m)                                                    as f006m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 370 }]
      @Aggregation.default: #SUM
      sum(_sb.f006a)                                                    as f006a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 380 }]
      cast( case when sum(_sb.f006m) = 0 or sum(_sb.f006a) = 0 then 0
            else sum(_sb.f006a) / sum(_sb.f006m) end as abap.dec(20,0)) as f006d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 390 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f007m)                                                    as f007m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 400 }]
      @Aggregation.default: #SUM
      sum(_sb.f007a)                                                    as f007a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 410 }]
      cast( case when sum(_sb.f007m) = 0 or sum(_sb.f007a) = 0 then 0
            else sum(_sb.f007a) / sum(_sb.f007m) end as abap.dec(20,0)) as f007d,

      @EndUserText.label: '입고합계수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 420 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f008m)                                                    as f008m,

      @EndUserText.label: '입고합계금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 430 }]
      @Aggregation.default: #SUM
      sum(_sb.f008a)                                                    as f008a,

      @EndUserText.label: '입고합계단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 440 }]
      cast( case when sum(_sb.f008m) = 0 or sum(_sb.f008a) = 0 then 0
            else sum(_sb.f008a) / sum(_sb.f008m) end as abap.dec(20,0)) as f008d,

      @EndUserText.label: '누적합계수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 450 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f009m)                                                    as f009m,

      @EndUserText.label: '누적합계금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 460 }]
      @Aggregation.default: #SUM
      sum(_sb.f009a)                                                    as f009a,

      @EndUserText.label: '누적합계단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 470 }]
      cast( case when sum(_sb.f009m) = 0 or sum(_sb.f009a) = 0 then 0
            else sum(_sb.f009a) / sum(_sb.f009m) end as abap.dec(20,0)) as f009d,

      @EndUserText.label: '판매출고수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 480 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f010m)                                                    as f010m,

      @EndUserText.label: '판매출고금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 490 }]
      @Aggregation.default: #SUM
      sum(_sb.f010a)                                                    as f010a,

      @EndUserText.label: '판매출고단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 500 }]
      cast( case when sum(_sb.f010m) = 0 or sum(_sb.f010a) = 0 then 0
            else sum(_sb.f010a) / sum(_sb.f010m) end as abap.dec(20,0)) as f010d,

      @EndUserText.label: '생산출고수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 510 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f011m)                                                    as f011m,

      @EndUserText.label: '생산출고금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 520 }]
      @Aggregation.default: #SUM
      sum(_sb.f011a)                                                    as f011a,

      @EndUserText.label: '생산출고단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 530 }]
      cast( case when sum(_sb.f011m) = 0 or sum(_sb.f011a) = 0 then 0
            else sum(_sb.f011a) / sum(_sb.f011m) end as abap.dec(20,0)) as f011d,

      @EndUserText.label: '창고이동출고수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 540 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f012m)                                                    as f012m,

      @EndUserText.label: '창고이동출고금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 550 }]
      @Aggregation.default: #SUM
      sum(_sb.f012a)                                                    as f012a,

      @EndUserText.label: '창고이동출고단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 560 }]
      cast( case when sum(_sb.f012m) = 0 or sum(_sb.f012a) = 0 then 0
            else sum(_sb.f012a) / sum(_sb.f012m) end as abap.dec(20,0)) as f012d,

      @EndUserText.label: '부서출고수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 570 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f013m)                                                    as f013m,

      @EndUserText.label: '부서출고금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 580 }]
      @Aggregation.default: #SUM
      sum(_sb.f013a)                                                    as f013a,

      @EndUserText.label: '부서출고단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 590 }]
      cast( case when sum(_sb.f013m) = 0 or sum(_sb.f013a) = 0 then 0
            else sum(_sb.f013a) / sum(_sb.f013m) end as abap.dec(20,0)) as f013d,

      @EndUserText.label: '폐기수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 600 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f014m)                                                    as f014m,

      @EndUserText.label: '폐기금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 610 }]
      @Aggregation.default: #SUM
      sum(_sb.f014a)                                                    as f014a,

      @EndUserText.label: '폐기단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 620 }]
      cast( case when sum(_sb.f014m) = 0 or sum(_sb.f014a) = 0 then 0
            else sum(_sb.f014a) / sum(_sb.f014m) end as abap.dec(20,0)) as f014d,

      @EndUserText.label: '기타출고수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 630 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f015m)                                                    as f015m,

      @EndUserText.label: '기타출고금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 640 }]
      @Aggregation.default: #SUM
      sum(_sb.f015a)                                                    as f015a,

      @EndUserText.label: '기타출고단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 650 }]
      cast( case when sum(_sb.f015m) = 0 or sum(_sb.f015a) = 0 then 0
            else sum(_sb.f015a) / sum(_sb.f015m) end as abap.dec(20,0)) as f015d,

      @EndUserText.label: 'SL차이보정수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 660 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f016m)                                                    as f016m,

      @EndUserText.label: 'SL차이보정금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 670 }]
      @Aggregation.default: #SUM
      sum(_sb.f016a)                                                    as f016a,

      @EndUserText.label: 'SL차이보정단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 680 }]
      cast( case when sum(_sb.f016m) = 0 or sum(_sb.f016a) = 0 then 0
            else sum(_sb.f016a) / sum(_sb.f016m) end as abap.dec(20,0)) as f016d,

      @EndUserText.label: '가격차이수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 690 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f017m)                                                    as f017m,


      @EndUserText.label: '가격차이금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 700 }]
      @Aggregation.default: #SUM
      sum(_sb.f017a)                                                    as f017a,

      @EndUserText.label: '가격차이단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 710 }]
      cast( case when sum(_sb.f017m) = 0 or sum(_sb.f017a) = 0 then 0
            else sum(_sb.f017a) / sum(_sb.f017m) end as abap.dec(20,0)) as f017d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 720 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f018m)                                                    as f018m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 730 }]
      @Aggregation.default: #SUM
      sum(_sb.f018a)                                                    as f018a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 740 }]
      cast( case when sum(_sb.f018m) = 0 or sum(_sb.f018a) = 0 then 0
            else sum(_sb.f018a) / sum(_sb.f018m) end as abap.dec(20,0)) as f018d,

      @EndUserText.label: '출고합계수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 750 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f019m)                                                    as f019m,

      @EndUserText.label: '출고합계금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 760 }]
      @Aggregation.default: #SUM
      sum(_sb.f019a)                                                    as f019a,

      @EndUserText.label: '출고합계단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 770 }]
      cast( case when sum(_sb.f019m) = 0 or sum(_sb.f019a) = 0 then 0
            else sum(_sb.f019a) / sum(_sb.f019m) end as abap.dec(20,0)) as f019d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 780 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f020m)                                                    as f020m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 790 }]
      @Aggregation.default: #SUM
      sum(_sb.f020a)                                                    as f020a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 800 }]
      cast( case when sum(_sb.f020m) = 0 or sum(_sb.f020a) = 0 then 0
            else sum(_sb.f020a) / sum(_sb.f020m) end as abap.dec(20,0)) as f020d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 810 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f021m)                                                    as f021m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 820 }]
      @Aggregation.default: #SUM
      sum(_sb.f021a)                                                    as f021a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 830 }]
      cast( case when sum(_sb.f021m) = 0 or sum(_sb.f021a) = 0 then 0
            else sum(_sb.f021a) / sum(_sb.f021m) end as abap.dec(20,0)) as f021d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 840 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f022m)                                                    as f022m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 850 }]
      @Aggregation.default: #SUM
      sum(_sb.f022a)                                                    as f022a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 860 }]
      cast( case when sum(_sb.f022m) = 0 or sum(_sb.f022a) = 0 then 0
            else sum(_sb.f022a) / sum(_sb.f022m) end as abap.dec(20,0)) as f022d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 870 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f023m)                                                    as f023m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 880 }]
      @Aggregation.default: #SUM
      sum(_sb.f023a)                                                    as f023a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 890 }]
      cast( case when sum(_sb.f023m) = 0 or sum(_sb.f023a) = 0 then 0
            else sum(_sb.f023a) / sum(_sb.f023m) end as abap.dec(20,0)) as f023d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 900 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f024m)                                                    as f024m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 910 }]
      @Aggregation.default: #SUM
      sum(_sb.f024a)                                                    as f024a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 920 }]
      cast( case when sum(_sb.f024m) = 0 or sum(_sb.f024a) = 0 then 0
            else sum(_sb.f024a) / sum(_sb.f024m) end as abap.dec(20,0)) as f024d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 930 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f025m)                                                    as f025m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 940 }]
      @Aggregation.default: #SUM
      sum(_sb.f025a)                                                    as f025a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 950 }]
      cast( case when sum(_sb.f025m) = 0 or sum(_sb.f025a) = 0 then 0
            else sum(_sb.f025a) / sum(_sb.f025m) end as abap.dec(20,0)) as f025d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 960 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f026m)                                                    as f026m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 970 }]
      @Aggregation.default: #SUM
      sum(_sb.f026a)                                                    as f026a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 980 }]
      cast( case when sum(_sb.f026m) = 0 or sum(_sb.f026a) = 0 then 0
            else sum(_sb.f026a) / sum(_sb.f026m) end as abap.dec(20,0)) as f026d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 990 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f027m)                                                    as f027m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1000 }]
      @Aggregation.default: #SUM
      sum(_sb.f027a)                                                    as f027a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1010 }]
      cast( case when sum(_sb.f027m) = 0 or sum(_sb.f027a) = 0 then 0
            else sum(_sb.f027a) / sum(_sb.f027m) end as abap.dec(20,0)) as f027d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1020 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f028m)                                                    as f028m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1030 }]
      @Aggregation.default: #SUM
      sum(_sb.f028a)                                                    as f028a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1040 }]
      cast( case when sum(_sb.f028m) = 0 or sum(_sb.f028a) = 0 then 0
            else sum(_sb.f028a) / sum(_sb.f028m) end as abap.dec(20,0)) as f028d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1050 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f029m)                                                    as f029m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1060 }]
      @Aggregation.default: #SUM
      sum(_sb.f029a)                                                    as f029a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1070 }]
      cast( case when sum(_sb.f029m) = 0 or sum(_sb.f029a) = 0 then 0
            else sum(_sb.f029a) / sum(_sb.f029m) end as abap.dec(20,0)) as f029d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1080 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f030m)                                                    as f030m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1090 }]
      @Aggregation.default: #SUM
      sum(_sb.f030a)                                                    as f030a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1100 }]
      cast( case when sum(_sb.f030m) = 0 or sum(_sb.f030a) = 0 then 0
            else sum(_sb.f030a) / sum(_sb.f030m) end as abap.dec(20,0)) as f030d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1110 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f031m)                                                    as f031m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1120 }]
      @Aggregation.default: #SUM
      sum(_sb.f031a)                                                    as f031a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1130 }]
      cast( case when sum(_sb.f031m) = 0 or sum(_sb.f031a) = 0 then 0
            else sum(_sb.f031a) / sum(_sb.f031m) end as abap.dec(20,0)) as f031d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1140 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f032m)                                                    as f032m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1150 }]
      @Aggregation.default: #SUM
      sum(_sb.f032a)                                                    as f032a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1160 }]
      cast( case when sum(_sb.f032m) = 0 or sum(_sb.f032a) = 0 then 0
            else sum(_sb.f032a) / sum(_sb.f032m) end as abap.dec(20,0)) as f032d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1170 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f033m)                                                    as f033m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1180 }]
      @Aggregation.default: #SUM
      sum(_sb.f033a)                                                    as f033a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1190 }]
      cast( case when sum(_sb.f033m) = 0 or sum(_sb.f033a) = 0 then 0
            else sum(_sb.f033a) / sum(_sb.f033m) end as abap.dec(20,0)) as f033d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1200 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f034m)                                                    as f034m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1210 }]
      @Aggregation.default: #SUM
      sum(_sb.f034a)                                                    as f034a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1220 }]
      cast( case when sum(_sb.f034m) = 0 or sum(_sb.f034a) = 0 then 0
            else sum(_sb.f034a) / sum(_sb.f034m) end as abap.dec(20,0)) as f034d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1230 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f035m)                                                    as f035m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1240 }]
      @Aggregation.default: #SUM
      sum(_sb.f035a)                                                    as f035a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1250 }]
      cast( case when sum(_sb.f035m) = 0 or sum(_sb.f035a) = 0 then 0
            else sum(_sb.f035a) / sum(_sb.f035m) end as abap.dec(20,0)) as f035d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1260 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f036m)                                                    as f036m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1270 }]
      @Aggregation.default: #SUM
      sum(_sb.f036a)                                                    as f036a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1280 }]
      cast( case when sum(_sb.f036m) = 0 or sum(_sb.f036a) = 0 then 0
            else sum(_sb.f036a) / sum(_sb.f036m) end as abap.dec(20,0)) as f036d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1290 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f037m)                                                    as f037m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1300 }]
      @Aggregation.default: #SUM
      sum(_sb.f037a)                                                    as f037a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1310 }]
      cast( case when sum(_sb.f037m) = 0 or sum(_sb.f037a) = 0 then 0
            else sum(_sb.f037a) / sum(_sb.f037m) end as abap.dec(20,0)) as f037d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1320 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f038m)                                                    as f038m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1330 }]
      @Aggregation.default: #SUM
      sum(_sb.f038a)                                                    as f038a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1340 }]
      cast( case when sum(_sb.f038m) = 0 or sum(_sb.f038a) = 0 then 0
            else sum(_sb.f038a) / sum(_sb.f038m) end as abap.dec(20,0)) as f038d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1350 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f039m)                                                    as f039m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1360 }]
      @Aggregation.default: #SUM
      sum(_sb.f039a)                                                    as f039a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1370 }]
      cast( case when sum(_sb.f039m) = 0 or sum(_sb.f039a) = 0 then 0
            else sum(_sb.f039a) / sum(_sb.f039m) end as abap.dec(20,0)) as f039d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1380 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f040m)                                                    as f040m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1390 }]
      @Aggregation.default: #SUM
      sum(_sb.f040a)                                                    as f040a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1400 }]
      cast( case when sum(_sb.f040m) = 0 or sum(_sb.f040a) = 0 then 0
            else sum(_sb.f040a) / sum(_sb.f040m) end as abap.dec(20,0)) as f040d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1410 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f041m)                                                    as f041m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1420 }]
      @Aggregation.default: #SUM
      sum(_sb.f041a)                                                    as f041a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1430 }]
      cast( case when sum(_sb.f041m) = 0 or sum(_sb.f041a) = 0 then 0
            else sum(_sb.f041a) / sum(_sb.f041m) end as abap.dec(20,0)) as f041d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1440 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f042m)                                                    as f042m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1450 }]
      @Aggregation.default: #SUM
      sum(_sb.f042a)                                                    as f042a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1460 }]
      cast( case when sum(_sb.f042m) = 0 or sum(_sb.f042a) = 0 then 0
            else sum(_sb.f042a) / sum(_sb.f042m) end as abap.dec(20,0)) as f042d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1470 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f043m)                                                    as f043m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1480 }]
      @Aggregation.default: #SUM
      sum(_sb.f043a)                                                    as f043a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1490 }]
      cast( case when sum(_sb.f043m) = 0 or sum(_sb.f043a) = 0 then 0
            else sum(_sb.f043a) / sum(_sb.f043m) end as abap.dec(20,0)) as f043d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1500 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f044m)                                                    as f044m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1510 }]
      @Aggregation.default: #SUM
      sum(_sb.f044a)                                                    as f044a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1520 }]
      cast( case when sum(_sb.f044m) = 0 or sum(_sb.f044a) = 0 then 0
            else sum(_sb.f044a) / sum(_sb.f044m) end as abap.dec(20,0)) as f044d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1530 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f045m)                                                    as f045m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1540 }]
      @Aggregation.default: #SUM
      sum(_sb.f045a)                                                    as f045a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1550 }]
      cast( case when sum(_sb.f045m) = 0 or sum(_sb.f045a) = 0 then 0
            else sum(_sb.f045a) / sum(_sb.f045m) end as abap.dec(20,0)) as f045d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1560 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f046m)                                                    as f046m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1570 }]
      @Aggregation.default: #SUM
      sum(_sb.f046a)                                                    as f046a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1580 }]
      cast( case when sum(_sb.f046m) = 0 or sum(_sb.f046a) = 0 then 0
            else sum(_sb.f046a) / sum(_sb.f046m) end as abap.dec(20,0)) as f046d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1590 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f047m)                                                    as f047m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1600 }]
      @Aggregation.default: #SUM
      sum(_sb.f047a)                                                    as f047a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1610 }]
      cast( case when sum(_sb.f047m) = 0 or sum(_sb.f047a) = 0 then 0
            else sum(_sb.f047a) / sum(_sb.f047m) end as abap.dec(20,0)) as f047d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1620 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f048m)                                                    as f048m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1630 }]
      @Aggregation.default: #SUM
      sum(_sb.f048a)                                                    as f048a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1640 }]
      cast( case when sum(_sb.f048m) = 0 or sum(_sb.f048a) = 0 then 0
            else sum(_sb.f048a) / sum(_sb.f048m) end as abap.dec(20,0)) as f048d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1650 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f049m)                                                    as f049m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1660 }]
      @Aggregation.default: #SUM
      sum(_sb.f049a)                                                    as f049a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1670 }]
      cast( case when sum(_sb.f049m) = 0 or sum(_sb.f049a) = 0 then 0
            else sum(_sb.f049a) / sum(_sb.f049m) end as abap.dec(20,0)) as f049d,

      @EndUserText.label: '기말수량'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1680 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      _ed.f050m                                                         as f050m,

      @EndUserText.label: '기말금액'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1690 }]
      @Aggregation.default: #SUM
      _ed.f050a                                                         as f050a,

      @EndUserText.label: '기말단가'
      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1700 }]
      _ed.f050d                                                         as f050d,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1710 }]
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'meins'
      sum(_sb.f099m)                                                    as f099m,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1720 }]
      @Aggregation.default: #SUM
      sum(_sb.f099a)                                                    as f099a,

      @Consumption.filter.hidden: true
      @UI.lineItem: [{ position: 1730 }]
      cast( case when sum(_sb.f099m) = 0 or sum(_sb.f099a) = 0 then 0
            else sum(_sb.f099a) / sum(_sb.f099m) end as abap.dec(20,0)) as f099d
}
where
       _sb.spmon between $parameters.sspmon and $parameters.espmon
  and(
       _sb.f000m <> 0
    or _sb.f001m <> 0
    or _sb.f002m <> 0
    or _sb.f003m <> 0
    or _sb.f004m <> 0
    or _sb.f005m <> 0
    or _sb.f006m <> 0
    or _sb.f007m <> 0
    or _sb.f008m <> 0
    or _sb.f009m <> 0
    or _sb.f010m <> 0
    or _sb.f011m <> 0
    or _sb.f012m <> 0
    or _sb.f013m <> 0
    or _sb.f014m <> 0
    or _sb.f015m <> 0
    or _sb.f016m <> 0
    or _sb.f017m <> 0
    or _sb.f018m <> 0
    or _sb.f019m <> 0
    or _sb.f020m <> 0
    or _sb.f021m <> 0
    or _sb.f022m <> 0
    or _sb.f023m <> 0
    or _sb.f024m <> 0
    or _sb.f025m <> 0
    or _sb.f026m <> 0
    or _sb.f027m <> 0
    or _sb.f028m <> 0
    or _sb.f029m <> 0
    or _sb.f030m <> 0
    or _sb.f031m <> 0
    or _sb.f032m <> 0
    or _sb.f033m <> 0
    or _sb.f034m <> 0
    or _sb.f035m <> 0
    or _sb.f036m <> 0
    or _sb.f037m <> 0
    or _sb.f038m <> 0
    or _sb.f039m <> 0
    or _sb.f040m <> 0
    or _sb.f041m <> 0
    or _sb.f042m <> 0
    or _sb.f043m <> 0
    or _sb.f044m <> 0
    or _sb.f045m <> 0
    or _sb.f046m <> 0
    or _sb.f047m <> 0
    or _sb.f048m <> 0
    or _sb.f049m <> 0
    or _sb.f050m <> 0
    or _sb.f099m <> 0
    or _sb.f000a <> 0
    or _sb.f001a <> 0
    or _sb.f002a <> 0
    or _sb.f003a <> 0
    or _sb.f004a <> 0
    or _sb.f005a <> 0
    or _sb.f006a <> 0
    or _sb.f007a <> 0
    or _sb.f008a <> 0
    or _sb.f009a <> 0
    or _sb.f010a <> 0
    or _sb.f011a <> 0
    or _sb.f012a <> 0
    or _sb.f013a <> 0
    or _sb.f014a <> 0
    or _sb.f015a <> 0
    or _sb.f016a <> 0
    or _sb.f017a <> 0
    or _sb.f018a <> 0
    or _sb.f019a <> 0
    or _sb.f020a <> 0
    or _sb.f021a <> 0
    or _sb.f022a <> 0
    or _sb.f023a <> 0
    or _sb.f024a <> 0
    or _sb.f025a <> 0
    or _sb.f026a <> 0
    or _sb.f027a <> 0
    or _sb.f028a <> 0
    or _sb.f029a <> 0
    or _sb.f030a <> 0
    or _sb.f031a <> 0
    or _sb.f032a <> 0
    or _sb.f033a <> 0
    or _sb.f034a <> 0
    or _sb.f035a <> 0
    or _sb.f036a <> 0
    or _sb.f037a <> 0
    or _sb.f038a <> 0
    or _sb.f039a <> 0
    or _sb.f040a <> 0
    or _sb.f041a <> 0
    or _sb.f042a <> 0
    or _sb.f043a <> 0
    or _sb.f044a <> 0
    or _sb.f045a <> 0
    or _sb.f046a <> 0
    or _sb.f047a <> 0
    or _sb.f048a <> 0
    or _sb.f049a <> 0
    or _sb.f050a <> 0
    or _sb.f099a <> 0
  )
group by
//  _sb.spmon,
  _sb.bwkey,
  _sb.matnr,
  _makt.ProductName,
  _sb.bklas,
  _Bkl.ValuationClassDescription,
  _mara.ExternalProductGroup,
  _Epg.ExternalProductGroupName,
  _mara.ProductGroup,
  _Matkl.ProductGroupText,
//  _mara.YY1_MAT_MAKER_PRD,
//  _Mcat.Ztext,
//  _mara.YY1_PROD_RANGE_PRD,
//  _Maker.Ztext,
//  _mara.YY1_MAT_JJ_PRD,
//  _mara.YY1_MAT_PNP_PRD,
  _sb.meins,
  _sb.waers,
  _ab.f000m,
  _ab.f000a,
  _ab.f000d,
  _ed.f050m,
  _ed.f050a,
  _ed.f050d
