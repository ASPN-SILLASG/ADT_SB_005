@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SSB] 월 수불부 기말 취합용'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZSB_I_0005_02 as select from zassbt0000 as _ed
{
   key _ed.spmon,
   key _ed.matnr,
   @EndUserText.label: '단위'
   _ed.meins,
   @EndUserText.label: '통화'
   _ed.waers,
   @Semantics.quantity.unitOfMeasure: 'meins'
   sum(_ed.f050m)                                                    as f050m,
   sum(_ed.f050a)                                                    as f050a,
   cast( case when sum(_ed.f050m) = 0 or sum(_ed.f050a) = 0 then 0
         else sum(_ed.f050a) / sum(_ed.f050m) end as abap.dec(20,0)) as f050d
} 
group by _ed.spmon,
         _ed.matnr,
         _ed.meins,
         _ed.waers
