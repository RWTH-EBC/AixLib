within AixLib.FastHVAC.Components.Storage.BaseClasses;
model HeatTransfer_directed_heat_transfer_f

//  import BufferStorage = BufferStorage2;
  extends
    AixLib.FastHVAC.Components.Storage.BaseClasses.Partial_HeatTransfer_Layers;
  Modelica.SIunits.HeatFlowRate[n-1] Q_flow
    "Heat flow rate from layer i+1 to i";
  //Modelica.Thermal.HeatTransfer.TemperatureSensor[n] temperatureSensor
   // annotation 2;

  Modelica.SIunits.HeatFlowRate[ n] Q_buoy_abs
  "Cumulative heat flow rate into the layer due to buoyancy";

  parameter Modelica.SIunits.Time tau=100;
  parameter Modelica.SIunits.TemperatureDifference dTref=1;
  function f_Qbuoy =
      AixLib.FastHVAC.Components.Storage.BaseClasses.Q_buoy_function;

protected
  parameter Modelica.SIunits.Length height=data.hTank/n
    "height of fluid layers";
  parameter Modelica.SIunits.Area A=Modelica.Constants.pi/4*data.dTank^2
    "Area of heat transfer between layers";
  Modelica.SIunits.TemperatureDifference dT[n-1]
    "Temperature difference between adjoining volumes";

  parameter Modelica.SIunits.ThermalConductivity lambda_water=0.64;
  parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple medium=
      AixLib.FastHVAC.Media.WaterSimple();

equation
  //buoyancy heat distribution
  Q_buoy_abs = f_Qbuoy(
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

  //below line is new

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Model for heat transfer between buffer storage layers. Models conductance of water. An effective heat conductivity is therefore calculated. Used in BufferStorage model.</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/> </p>
<p><h4><font color=\"#008000\">Sources</font></h4></p>
<p>R. Viskanta, A. KaraIds: Interferometric observations of the temperature structure in water cooled or heated from above. <i>Advances in Water Resources,</i> volume 1, 1977, pages 57-69. Bibtex-Key [R.VISKANTA1977]</p>
</html>",
   revisions="<html>
<p><ul>
<li><i>December 20, 2016&nbsp; </i> Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>December 10, 2013</i> by Kristian Huchtemann:<br/>New implementation in source code. Documentation.</li>
<li><i>October 2, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately </li>
</ul></p>
</html>"),
    Icon(graphics={Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,255},
          textString="%name")}));
end HeatTransfer_directed_heat_transfer_f;
