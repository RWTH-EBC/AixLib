within AixLib.Fluid.Storage.BaseClasses;
model HeatTransferLambdaSimple "Heat transfer with effective conductivity"
  extends AixLib.Fluid.Storage.BaseClasses.PartialHeatTransferLayers;

  Modelica.Units.SI.HeatFlowRate[n - 1] qFlow
    "Heat flow rate from segment i+1 to i";

  parameter Modelica.Units.SI.ThermalConductivity const_lambda_eff=100
    "Effective thermal conductivity";

  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid[n - 1](
    each u(start=false),
    rising=100,
    falling=10,
    amplitude=const_lambda_eff,
    offset=lambdaWater)
    "Triggered trapezoid for conductivity between layers"
                annotation (Placement(transformation(extent={{-20,0},{0,20}},
                   rotation=0)));

protected
  parameter Modelica.Units.SI.Length height=data.hTank/n
    "Height of fluid layers";
  parameter Modelica.Units.SI.Area A=Modelica.Constants.pi/4*data.dTank^2
    "Area of heat transfer between layers";
  Modelica.Units.SI.TemperatureDifference dT[n - 1]
    "Temperature difference between adjoining volumes";
  Modelica.Units.SI.ThermalConductance k[n - 1]
    "Effective heat transfer coefficient";
  parameter Modelica.Units.SI.ThermalConductivity lambdaWater=0.64
    "Thermal conductivity of water";

equation

  for i in 1:n-1 loop
    dT[i] = therm[i].T-therm[i+1].T;
    triggeredTrapezoid[i].u=dT[i]>0;
    k[i]=triggeredTrapezoid[i].y*A/height;
    qFlow[i] = k[i]*dT[i];
  end for;

  // Positive heat flows here mean negative heat flows for the fluid layers
  therm[1].Q_flow = qFlow[1];
  for i in 2:n-1 loop
       therm[i].Q_flow = -qFlow[i-1]+qFlow[i];
  end for;
  therm[n].Q_flow = -qFlow[n-1];
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for heat transfer between buffer storage layers. Models
  conductance of water and additional effective conductivity (in case
  the above layer is colder than the lower layer). Used in
  BufferStorage model.
</p>
</html>",
   revisions="<html><ul>
  <li>
    <i>October 12, 2016&#160;</i> by Marcus Fuchs:<br/>
    Add comments and fix documentation
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Sebastian Stinner:<br/>
    Added to AixLib
  </li>
  <li>
    <i>December 10, 2013</i> by Kristian Huchtemann:<br/>
    New implementation in source code. Documentation.
  </li>
  <li>
    <i>October 2, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"),
    Icon(graphics={Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,255},
          textString="%name")}));
end HeatTransferLambdaSimple;
