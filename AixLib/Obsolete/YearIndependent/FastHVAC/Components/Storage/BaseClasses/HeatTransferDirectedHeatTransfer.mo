within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses;
model HeatTransferDirectedHeatTransfer

//  import BufferStorage = BufferStorage2;
  extends
    AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.PartialHeatTransferLayers;
  Modelica.Units.SI.HeatFlowRate[n - 1] Q_flow
    "Heat flow rate from layer i+1 to i due to heat conduction";
  //Modelica.Thermal.HeatTransfer.TemperatureSensor[n] temperatureSensor
   // annotation 2;

  Modelica.Units.SI.HeatFlowRate[n] Q_buoy_abs
    "Cumulative heat flow rate into the layer due to buoyancy";

  parameter Modelica.Units.SI.Time tau=100;
  parameter Modelica.Units.SI.TemperatureDifference dTref=1;
  function fQbuoy =
      AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunction;

protected
  parameter Modelica.Units.SI.Length height=data.hTank/n
    "height of fluid layers";
  parameter Modelica.Units.SI.Area A=Modelica.Constants.pi/4*data.dTank^2
    "Area of heat transfer between layers";
  Modelica.Units.SI.TemperatureDifference dT[n - 1]
    "Temperature difference between adjoining volumes";

  parameter Modelica.Units.SI.ThermalConductivity lambda_water=0.64;
  parameter
    AixLib.Obsolete.YearIndependent.FastHVAC.Media.BaseClasses.MediumSimple
    medium=AixLib.Obsolete.YearIndependent.FastHVAC.Media.WaterSimple();

equation
  //buoyancy heat distribution to the different layers
  Q_buoy_abs =fQbuoy(
    n,
    height,
    A,
    therm.T,
    medium,
    tau,
    dTref);
  for i in 1:n-1 loop
    dT[i] = therm[i].T - therm[i + 1].T;
    Q_flow[i] = lambda_water*A/height*dT[i];
  end for;
//positive heat flows here mean negativ heat flows for the fluid layers
  therm[1].Q_flow = Q_flow[1]-Q_buoy_abs[1];
  for i in 2:n-1 loop
       therm[i].Q_flow = -Q_flow[i - 1] + Q_flow[i]-Q_buoy_abs[i];
  end for;

  therm[n].Q_flow = -Q_flow[n - 1]-Q_buoy_abs[n];

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for heat transfer between buffer storage layers. Models
  conductance of water. Buoyancy and conduction are considered
  individually
</p>
<h4>
  <span style=\"color:#008000\">Sources</span>
</h4>
<p>
  Total massflow by buoyancy is calculated by a fixed time Tau, a fixed
  dT_ref and the actual temperature difference between the layers dT.
  The partial mass ratio that goes to each layer is calculated by a
  selectable predefined profile (buoyancyDistribution).
</p>
<p>
  Model was developed by Christian Grozescu in his master thesis
  <i>Extension of Thermal Storage Models for Energy System
  Simulations</i>, 2017
</p>
</html>",
   revisions="<html><ul>
  <li>
    <i>October 19, 2017&#160;</i> David Jansen:<br/>
    Added informations and commentations to source code and changed
    names according to AixLib regulations
  </li>
  <li>
    <i>March , 2017&#160;</i> Christian Grozescu :<br/>
    Developed model
  </li>
</ul>
</html>"),
    Icon(graphics={Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,255},
          textString="%name")}));
end HeatTransferDirectedHeatTransfer;
