within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D;
record VZH088AG
  "Data for Danfoss VZH088AG scroll compressor machine"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.Generic(
    facGai={1,1,100},
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    scaleUnitsQCon_flow={"K","K",""},
    dataUnitQCon_flow="W",
    datasetQCon_flow="/QCon",
    scaleUnitsPEle={"K","K",""},
    dataUnitPEle="W",
    datasetPEle="/Pel",
    filename="modelica://AixLib/Resources/Data/Fluid/HeatPumps/ModularReversible/Data/LookUpTable3D/VZH088AG.sdf",
    devIde="VZH088AG");

  annotation (Documentation(info="<html>
<p>Data is based on sheet provided at 
 <a href=\"https://www.dwgeire.ie/media/pdf/92/12/96/VZH_Inverter_scroll_compressor_R410A.pdf\">
https://www.dwgeire.ie/media/pdf/92/12/96/VZH_Inverter_scroll_compressor_R410A.pdf</a>
</p>
</html>"));
end VZH088AG;
