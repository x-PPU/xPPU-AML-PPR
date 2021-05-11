let $x := doc("../xPPU.aml")
let $EveryTopProcess := $x/CAEXFile/InstanceHierarchy/InternalElement[@Name='Processes']//InternalElement
let $EveryProduct := $x//InternalElement[@Name='Product1'] union $x//InternalElement[@Name='Product2'] union $x//InternalElement[@Name='Product3']
let $EveryProductConnection := $EveryProduct//@RefPartnerSideA union $EveryProduct//@RefPartnerSideB
let $EveryResource := $x//InternalElement[@Name='xPPU']/InternalElement
let $EveryResourceConnection := $EveryResource//@RefPartnerSideA union $EveryResource//@RefPartnerSideB

return 
<root>
{
  for $ProductConnection in $EveryProductConnection
  for $TopProcess in $EveryTopProcess
  where starts-with(data($ProductConnection),data($TopProcess/@ID))
  return 
  <Product>
  <Name>{data($ProductConnection/../../@Name)}</Name>
  <ID>{data($ProductConnection/../../@ID)}</ID>
  {
    let $AllSubProcesses := $TopProcess/InternalElement//InternalElement
    for $SubProcess in $AllSubProcesses
    return
    <Process>
      <Name>{data($SubProcess/@Name)}</Name>
      <ID>{data($SubProcess/@ID)}</ID>
      {
        for $ResourceConnection in $EveryResourceConnection
        where starts-with(data($ResourceConnection), data($SubProcess/@ID))
        return
        <Resource>
        <Name>{data($ResourceConnection/../../@Name)}</Name>
        <ID>{data($ResourceConnection/../../@ID)}</ID>
        </Resource>
      }
    </Process>
  }
  </Product>
}
</root>