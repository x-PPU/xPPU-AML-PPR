let $x := doc("../xPPU.aml")
let $EveryProcess := $x/CAEXFile/InstanceHierarchy/InternalElement[@Name='Processes']//InternalElement
let $EveryProduct := $x//InternalElement[@Name='Products']//InternalElement
let $EveryProductConnection := $EveryProduct//@RefPartnerSideA union $EveryProduct//@RefPartnerSideB
let $EveryResource := $x//InternalElement[@Name='xPPU']/InternalElement
let $EveryResourceConnection := $EveryResource//@RefPartnerSideA union $EveryResource//@RefPartnerSideB

return 
<root>
{
  for $Process in $EveryProcess
  return
  <Process>
     <Name>{data($Process/@Name)}</Name>
     <ID>{data($Process/@ID)}</ID>
   {
     for $ResourceConnection in $EveryResourceConnection
     where starts-with(string(data($ResourceConnection)),string(data($Process/@ID)))
     return 
     <Resource>
       <Name>{data($ResourceConnection/../../@Name)}</Name>
       <ID>{data($ResourceConnection/../../@ID)}</ID>
     {
     for $ProductConnection in $EveryProductConnection
     where starts-with(string(data($ProductConnection)),string(data($Process/@ID)))
     return 
       <Product>
         <Name>{data($ProductConnection/../../@Name)}</Name>
         <ID>{data($ProductConnection/../../@ID)}</ID>
       </Product>
     }
     </Resource>
   }
   </Process>
}
</root>
