within AixLib.Obsolete.YearIndependent.FastHVAC.BaseClasses;
model WorkingFluid

  parameter
    AixLib.Obsolete.YearIndependent.FastHVAC.Media.BaseClasses.MediumSimple
    medium=AixLib.Obsolete.YearIndependent.FastHVAC.Media.WaterSimple()
    "Mediums charastics (heat capacity, density, thermal conductivity)";
  parameter Modelica.Units.SI.Temperature T0 " Initial temperature";
  parameter Modelica.Units.SI.Mass m_fluid "Mass of working fluid";

  AixLib.Obsolete.YearIndependent.FastHVAC.BaseClasses.EnergyBalance energyBalance
    annotation (Placement(transformation(extent={{-34,-30},{26,30}})));
  AixLib.Obsolete.YearIndependent.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b
    "Enthalpie output port includes the parameter temperature, specific enthalpy, specific heat capacity and mass flow"
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  AixLib.Obsolete.YearIndependent.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a
    "Enthalpie input port includes the parameter temperature, specific enthalpy, specific heat capacity and mass flow"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
   C=m_fluid*medium.c, T(start=T0, fixed=true))
    annotation (Placement(transformation(extent={{-24,42},{16,82}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
  "Heat transfer into the working fluid"
    annotation (Placement(transformation(extent={{-10,84},{10,104}})));
equation
  connect(energyBalance.enthalpyPort_b, enthalpyPort_b) annotation (Line(
      points={{20,0},{90,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(energyBalance.enthalpyPort_a, enthalpyPort_a) annotation (Line(
      points={{-28,0},{-90,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(heatCapacitor.port, heatPort) annotation (Line(
      points={{-4,42},{26,42},{26,88},{0,88},{0,94}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatCapacitor.port, energyBalance.heatPort_a) annotation (Line(points=
         {{-4,42},{-4,42},{-4,24},{-4,24}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Text(
          extent={{-150,-82},{150,-122}},
          textString="%name",
          lineColor={0,0,255}),
          Ellipse(
          extent={{-90,90},{90,-90}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Sphere,
          fillColor={0,0,255}), Text(
          extent={{-50,18},{50,-18}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,0,255},
          textString="workingFluid")}),
    Documentation(info="<html><p>
  WorkingFluid is based on the models
  <code>FastHVAC.BaseClasses.EnergyBalance</code> and <a href=
  \"modelica:/Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">HeatCapacitor</a>.<br/>

  The heat transfer through the heatPort is ideal. It is used for
  FastHVAC fluid energy balances.
</p>
<ul>
  <li>
    <i>April 25, 2017</i>, by Michael Mans:<br/>
    Moved to AixLib
  </li>
  <li>
    <i>February 16, 2015&#160;</i> by Konstantin Finkbeiner:<br/>
    Implemented
  </li>
</ul>
</html> "));
end WorkingFluid;
