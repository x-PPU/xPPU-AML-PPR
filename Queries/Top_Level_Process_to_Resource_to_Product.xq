let $x := doc("../xPPU.aml")
let $EveryTopProcess := $x/CAEXFile/InstanceHierarchy/InternalElement[@Name='Processes']/InternalElement
let $EveryProcess := $x/CAEXFile/InstanceHierarchy/InternalElement[@Name='Processes']/InternalElement/InternalElement//InternalElement
let $EveryProduct := $x//InternalElement[@Name='Product1'] union $x//InternalElement[@Name='Product2'] union $x//InternalElement[@Name='Product3']
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
      for $ProductConnection in $EveryProductConnection
      where starts-with(data($ProductConnection),data($Process/../../@ID))
      return
      <Product>
        <Name>{data($ProductConnection/../../@Name)}</Name>
        <ID>{data($ProductConnection/../../@ID)}</ID>
        {
          for $ResourceConnection in $EveryResourceConnection
          where starts-with(data($ResourceConnection), data($Process/@ID))
          return
          <Resource>
            <Name>{data($ResourceConnection/../../@Name)}</Name>
            <ID>{data($ResourceConnection/../../@ID)}</ID>
          </Resource>
        }
      </Product>
    }
    </Process>
}
</root>