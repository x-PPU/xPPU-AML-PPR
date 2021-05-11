let $x := doc("../xPPU.aml")
let $EveryProcess := $x/CAEXFile/InstanceHierarchy/InternalElement[@Name='Processes']//InternalElement
let $EveryProduct := $x//InternalElement[@Name='Products']//InternalElement
let $EveryProductConnection := $EveryProduct//@RefPartnerSideA union $EveryProduct//@RefPartnerSideB
let $EveryResource := $x//InternalElement[@Name='xPPU']/InternalElement
let $EveryResourceConnection := $EveryResource//@RefPartnerSideA union $EveryResource//@RefPartnerSideB

return 
<root>
  {
  for $Product in $EveryProduct
  let $ProductConnections := $Product//@RefPartnerSideA union $Product//@RefPartnerSideB
  return 
  <Product>
    <Name>{data($Product/@Name)}</Name> 
    <ID>{data($Product/@ID)}</ID> 
    {
      for $ProductConnection in $ProductConnections
      for $Process in $EveryProcess
      where starts-with(data($ProductConnection),data($Process/@ID))
      return 
        <Process> 
          <Name>{(data($Process/@Name))}</Name>
          <ID>{(data($Process/@ID))}</ID>
          {
          for $ResourceConnection in $EveryResourceConnection
          where starts-with(data($ResourceConnection), data($Process/@ID))
          return 
            <Resource>
              <Name>{(data($ResourceConnection/../../@Name))}</Name>
              <ID>{(data($ResourceConnection/../../@ID))}</ID>
            </Resource>
          }
        </Process>
    }
  </Product>
  }
</root>