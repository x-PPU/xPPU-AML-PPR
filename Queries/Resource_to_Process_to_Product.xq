let $x := doc("../xPPU.aml")
let $EveryProcess := $x/CAEXFile/InstanceHierarchy/InternalElement[@Name='Processes']//InternalElement
let $EveryProduct := $x//InternalElement[@Name='Products']//InternalElement
let $EveryProductConnection := $EveryProduct//@RefPartnerSideA union $EveryProduct//@RefPartnerSideB
let $EveryResource := $x//InternalElement[@Name='xPPU']/InternalElement

return 
<root>
{
  for $Resource in $EveryResource
  let $ResourceConnections := $Resource//@RefPartnerSideA union $Resource//@RefPartnerSideB
  return
  <Resource>
     <Name>{data($Resource/@Name)}</Name>
     <ID>{data($Resource/@ID)}</ID>
   {
     for $Process in $EveryProcess
     for $ResourceConnection in $ResourceConnections
     where starts-with(string(data($ResourceConnection)),string(data($Process/@ID)))
     return 
     <Process>
       <Name>{data($Process/@Name)}</Name>
       <ID>{data($Process/@ID)}</ID>
       {
         for $ProductConnection in $EveryProductConnection
         where starts-with(string(data($ProductConnection)),string(data($Process/@ID)))
         return 
         <Product>
         <Name>{data($ProductConnection/../../@Name)}</Name>
         <ID>{data($ProductConnection/../../@Name)}</ID>
         </Product>
       }
     </Process>
     
   }
   </Resource>
}
</root>