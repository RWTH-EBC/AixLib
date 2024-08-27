within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D;
partial record Generic
  "Partial record for three-dimensional data for heat pumps"
  extends GenericHeatPump(final nDim=3);
  annotation (Documentation(info="<html>
<p>
  Data for three-dimensional performance data, assuming the following order: 
  (1) condenser temperature, (2) evaporator temperatur, 
  and (3) compressor speed. 
</p>
<p>
  If your table data has a different order, e.g. 
  (1) evaporator temperature, 
  (2) condenser temperatur, and (3) compressor speed, 
  specify <code>ourOrd={2, 1, 3}</code> to map 
  your order to the one assumed in the model.
</p>
</html>"));
end Generic;
