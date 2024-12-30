within AixLib.Fluid.SolarCollectors.PhotovoltaicThermal.Data;
partial record PhotovoltaicThermalBaseDataDefinition
  "Base Data Definition for photovoltaic thermal collectors"
  extends AixLib.Fluid.SolarCollectors.Data.GenericEN12975(
    dp_nominal=100,
    mperA_flow_nominal=0.02,
    mDry=20*A,
    V=0.001*A,
    C=0,
    IAMDiff=0.133,
    CTyp=AixLib.Fluid.SolarCollectors.Types.HeatCapacity.DryMass,
    A=2,
    incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,80,90}),
    incAngModDat={1.0,0.9967,0.9862,0.9671,0.9360,0.8868,0.8065,0.6686,0.4906,0.0});

  parameter Modelica.Units.SI.Efficiency etaEle_zero(max=1)
    "Conversion factor/Efficiency at Q = 0 for electrical efficiency";
  parameter Real mEle(unit="W/(m.m.K)")
    "Gradient of electrical efficiency linear approximation";
  annotation(Documentation(revisions="<html><ul>
  <li>
    <i>January 23, 2024</i> by Philipp Schmitz and Fabian Wuellhorst:<br/>
    First implementation. This is for
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1451\">
 issue 1451</a>.
  </li>
</ul>
</html>", info="<html>
<h4>
  Overview
</h4>
<p>
  This record extends the solar thermal collectors records and
  adds efficiency curves for the electrical part to enable a 
  model of a photovoltaic thermal collector.
  Note that the default values for angles, pressure drops and 
  panel area are generic assumptions based on values for 
  solar thermal collectors provided in <a href=
  \"modelica://AixLib.Fluid.SolarCollectors.Data\">AixLib.Fluid.SolarCollectors.Data</a>.
  If you want to model a specific device, check the general 
  UsersGuide for information on these parameters and set 
  them appropriately: <a href=
  \"modelica://AixLib.Fluid.SolarCollectors.UsersGuide\">AixLib.Fluid.SolarCollectors.UsersGuide</a>.
</p>
<h4>
  References
</h4>
<p>
  Record is used in model <a href=
  \"modelica://AixLib.Fluid.SolarCollectors.PhotovoltaicThermal.EN12975Curves\">AixLib.Fluid.SolarCollectors.PhotovoltaicThermal.EN12975Curves</a>.
</p>
</html>"));
end PhotovoltaicThermalBaseDataDefinition;
