within AixLib.Fluid.Chillers.ModularReversible.Data.TableDataSDF.TableData3D;
partial record Generic
  "Partial record for three-dimensional data for chillers"
  extends GenericChiller(final nDim=3);
  annotation (Documentation(info="<html>
<p>
  Data for three-dimensional performance data for chillers, assuming the following model input order: 
  (1) evaporator temperature, (2) condenser temperature, 
  and (3) compressor speed. 
</p>
<p>
  If your table data in the SDF file has a different axis order, e.g. 
  (1) compressor speed, 
  (2) condenser temperature, and (3) evaporator temperature (common for VCLibPy), 
  specify <code>outOrd={3, 1, 2}</code> to map the model inputs to the table axes.
</p>
</html>"));
end Generic;
