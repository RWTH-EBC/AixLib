within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;

function nzSplitVal
  "Distributor for NZ connectors"
  extends Modelica.Icons.Function;

  input Integer nPorts "Total number of NZ ports of all zones";
  input Integer[:] iPorts "Vector of zone indexes each port points to";
  output Real[nPorts,nPorts] nzSplitValues "Split factor values for ThermSplitter";
protected
  Integer j=1 "Row counter";
  Integer k=1 "Column counter";
  Integer l=1 "AArray counter";
algorithm
  for iSourcePort in 1:nPorts loop
    for iTargetPort in 1:nPorts loop
      if iTargetPort == iPorts[iSourcePort] then
        nzSplitValues[iSourcePort,iTargetPort] := 1;
      else
        nzSplitValues[iSourcePort,iTargetPort] := 0;
      end if;
    end for;
  end for;
end nzSplitVal;
