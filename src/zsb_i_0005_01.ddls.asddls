@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 월 수불부 기초 취합용'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZSB_I_0005_01 as select from zassbt0000 as _ab

{
   key _ab.spmon,
   key _ab.matnr,
   @EndUserText.label: '단위'
   _ab.meins,
   @EndUserText.label: '통화'
   _ab.waers,
   @Semantics.quantity.unitOfMeasure: 'meins'
   sum(_ab.f000m)                                                    as f000m,
   sum(_ab.f000a)                                                    as f000a,
   cast( case when sum(_ab.f000m) = 0 or sum(_ab.f000a) = 0 then 0
         else sum(_ab.f000a) / sum(_ab.f000m) end as abap.dec(20,0)) as f000d
      
} 
group by _ab.spmon,
         _ab.matnr,
         _ab.meins,
         _ab.waers
