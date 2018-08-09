within AixLib.FastHVAC.Components.Storage.BaseClasses;
model HeatTransferLambdaSimple

//  import BufferStorage = BufferStorage2;
  extends PartialHeatTransferLayers;
  Modelica.SIunits.HeatFlowRate[n-1] Q_flow
    "Heat flow rate from segment i+1 to i";
  //Modelica.Thermal.HeatTransfer.TemperatureSensor[n] temperatureSensor
   // annotation 2;
  parameter Modelica.SIunits.ThermalConductivity const_lambda_eff=100;

protected
  parameter Modelica.SIunits.Length height=data.hTank/n
    "height of fluid layers";
  parameter Modelica.SIunits.Area A=Modelica.Constants.pi/4*data.dTank^2
    "Area of heat transfer between layers";
  Modelica.SIunits.TemperatureDifference dT[n-1]
    "Temperature difference between adjoining volumes";
  Real[n-1] k(unit="W/K") "effective heat transfer coefficient";
  Real[n-1] lambda(unit="W/mK") "effective heat conductivity";
  parameter Modelica.SIunits.ThermalConductivity lambda_water=0.64;
public
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid[n - 1](
    u(start=false),
    rising=100,
    falling=10,
    amplitude=const_lambda_eff,
    offset=lambda_water)
                annotation (Placement(transformation(extent={{-20,0},{0,20}},
                   rotation=0)));
equation

  for i in 1:n-1 loop
    dT[i] = therm[i].T-therm[i+1].T;
    triggeredTrapezoid[i].u=dT[i]>0;
    k[i]=triggeredTrapezoid[i].y*A/height;
    Q_flow[i] = k[i]*dT[i];
  end for;

//positiv heat flows here mean negativ heat flows for the fluid layers
  therm[1].Q_flow = Q_flow[1];
  for i in 2:n-1 loop
       therm[i].Q_flow = -Q_flow[i-1]+Q_flow[i];
  end for;
  therm[n].Q_flow = -Q_flow[n-1];
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Documentation(info="<html><h4>
  <font color=\"#008000\">Overview</font>
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
    <i>December 20, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
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
