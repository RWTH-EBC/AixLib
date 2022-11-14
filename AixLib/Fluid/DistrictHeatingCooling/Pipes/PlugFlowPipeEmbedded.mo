within AixLib.Fluid.DistrictHeatingCooling.Pipes;
model PlugFlowPipeEmbedded
  "Embedded pipe model using spatialDistribution for temperature delay"

  extends AixLib.Fluid.Interfaces.PartialTwoPortVector(show_T=true);

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics", group="Equations"));

  parameter Boolean use_zeta=false
    "= true HydraulicResistance is implemented, zeta value has to be given next"
    annotation(Dialog(group="Additional pressurelosses"));

  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.Units.SI.Length dh=sqrt(4*m_flow_nominal/rho_default/
      v_nominal/Modelica.Constants.pi)
    "Hydraulic diameter (assuming a round cross section area)"
    annotation (Dialog(group="Material"));

  parameter Modelica.Units.SI.Velocity v_nominal=1.5
    "Velocity at m_flow_nominal (used to compute default value for hydraulic diameter dh)"
    annotation (Dialog(group="Nominal condition"));

  parameter Real ReC=4000
    "Reynolds number where transition to turbulent starts";

  parameter Modelica.Units.SI.Height roughness=2.5e-5
    "Average height of surface asperities (default: smooth steel pipe)"
    annotation (Dialog(group="Material"));

  parameter Modelica.Units.SI.Length length "Pipe length"
    annotation (Dialog(group="Material"));

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));

  parameter Modelica.Units.SI.MassFlowRate m_flow_small=1E-4*abs(m_flow_nominal)
    "Small mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.Units.SI.Length dIns
    "Thickness of pipe insulation, used to compute R"
    annotation (Dialog(group="Thermal resistance"));

  parameter Modelica.Units.SI.ThermalConductivity kIns
    "Heat conductivity of pipe insulation, used to compute R"
    annotation (Dialog(group="Thermal resistance"));

  parameter Modelica.Units.SI.SpecificHeatCapacity cPip=2300
    "Specific heat of pipe wall material. 2300 for PE, 500 for steel"
    annotation (Dialog(group="Material"));

  parameter Modelica.Units.SI.Density rhoPip(displayUnit="kg/m3") = 930
    "Density of pipe wall material. 930 for PE, 8000 for steel"
    annotation (Dialog(group="Material"));

  parameter Modelica.Units.SI.Length thickness=0.0035 "Pipe wall thickness"
    annotation (Dialog(group="Material"));

  parameter Modelica.Units.SI.Temperature T_start_in(start=Medium.T_default) =
    Medium.T_default "Initialization temperature at pipe inlet"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Temperature T_start_out(start=Medium.T_default)
     = T_start_in "Initialization temperature at pipe outlet"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean initDelay(start=false) = false
    "Initialize delay for a constant mass flow rate if true, otherwise start from 0"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_start=0
    "Initial value of mass flow rate through pipe"
    annotation (Dialog(tab="Initialization", enable=initDelay));

  parameter Real R(unit="(m.K)/W")=1/(kIns*2*Modelica.Constants.pi/
    Modelica.Math.log((dh/2 + dIns)/(dh/2)))
    "Thermal resistance per unit length from fluid to boundary temperature"
    annotation (Dialog(group="Thermal resistance"));

  parameter Real fac=1
    "Factor to take into account flow resistance of bends etc., fac=dp_nominal/dpStraightPipe_nominal"
    annotation (Dialog(group="Additional pressurelosses", enable=not use_zeta));

  parameter Real sum_zetas=0
    "Sum of all zeta values. Takes into account additional pressure drops due to bends/valves/etc."
    annotation (Dialog(group="Additional pressurelosses", enable=use_zeta));

  constant Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  parameter Boolean linearized = false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  //Ground/Soil: values for sandy soil with clay content based on "SIMULATIONSMODELL
  //"ERDWÄRMEKOLLEKTOR" zur wärmetechnischen Beurteilung von Wärmequellen,
  //Wärmesenken und Wärme-/Kältespeichern" by Bernd Glück

  parameter Modelica.Units.SI.Density rho_soi=1630 "Density of material/soil"
    annotation (Dialog(tab="Soil"));

  parameter Modelica.Units.SI.SpecificHeatCapacity c=1046
    "Specific heat capacity of material/soil" annotation (Dialog(tab="Soil"));
  parameter Modelica.Units.SI.Length thickness_soi=0.6
    "thickness of soil layer for heat loss calulcation"
    annotation (Dialog(tab="Soil"));

  parameter Modelica.Units.SI.ThermalConductivity lambda=1.5
    "Heat conductivity of material/soil" annotation (Dialog(tab="Soil"));

  final parameter Modelica.Units.SI.Length d_in=dh + 2*thickness
    "Inner diameter of pipe" annotation (Dialog(tab="Soil"));
  final parameter Integer nParallel = 1 "Number of identical parallel pipes"
  annotation(Dialog(tab="Soil"));
  final parameter Modelica.Units.SI.Temperature T0=289.15 "Initial temperature"
    annotation (Dialog(tab="Soil"));

  Modelica.Units.SI.Velocity v_med "Velocity of the medium in the pipe";

  AixLib.Fluid.DistrictHeatingCooling.Pipes.PlugFlowPipeZeta plugFlowPipeZeta(
    redeclare final package Medium = Medium,
    final dh=dh,
    final v_nominal=v_nominal,
    final ReC=ReC,
    final roughness=roughness,
    final length=length,
    final m_flow_nominal=m_flow_nominal,
    final dIns=dIns,
    final kIns=kIns,
    final cPip=cPip,
    final rhoPip=rhoPip,
    final thickness=thickness,
    final R=R,
    final fac=fac,
    final sum_zetas=sum_zetas,
    nPorts=nPorts,
    final use_zeta=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat transfer to or from surroundings (heat loss from pipe results in a positive heat flow)"
    annotation (Placement(transformation(extent={{-10,94},{10,114}}),
        iconTransformation(extent={{-10,94},{10,114}})));

  AixLib.Utilities.HeatTransfer.CylindricHeatTransfer cylindricHeatTransfer_1(
    final energyDynamics=energyDynamics,
    final rho=rho_soi,
    final c=c,
    final d_in=dh + 2*thickness,
    final d_out=d_in + thickness_soi/3,
    final length=length,
    final lambda=lambda,
    T0=283.15) annotation (Placement(transformation(extent={{-10,20},{10,40}})));

  AixLib.Utilities.HeatTransfer.CylindricHeatTransfer cylindricHeatTransfer_2(
    final energyDynamics=energyDynamics,
    final rho=rho_soi,
    final c=c,
    final d_in=dh + 2*thickness + thickness_soi/3,
    final d_out=d_in + 2*thickness_soi/3,
    final length=length,
    final lambda=lambda,
    T0=283.15) annotation (Placement(transformation(extent={{-10,46},{10,66}})));
  AixLib.Utilities.HeatTransfer.CylindricHeatTransfer cylindricHeatTransfer_3(
    final energyDynamics=energyDynamics,
    final rho=rho_soi,
    final c=c,
    final d_in=dh + 2*thickness + 2*thickness_soi/3,
    final d_out=d_in + thickness_soi,
    final length=length,
    final lambda=lambda,
    T0=283.15) annotation (Placement(transformation(extent={{-10,72},{10,92}})));


protected
  parameter Modelica.Units.SI.HeatCapacity CPip=length*((dh + 2*thickness)^2 -
      dh^2)*Modelica.Constants.pi/4*cPip*rhoPip "Heat capacity of pipe wall";

  final parameter Modelica.Units.SI.Volume VEqu=CPip/(rho_default*cp_default)
    "Equivalent medium volume to represent pipe wall thermal inertia";

  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default) "Default medium state";

  parameter Modelica.Units.SI.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(state=sta_default)
    "Heat capacity of medium";

  parameter Real C(unit="J/(K.m)")=
    rho_default*Modelica.Constants.pi*(dh/2)^2*cp_default
    "Thermal capacity per unit length of medium in pipe";

  parameter Modelica.Units.SI.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default)
    "Default density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(group="Advanced"));

equation
 //calculation of the flow velocity of medium in the pipes
 v_med = (4 * port_a.m_flow) / (Modelica.Constants.pi * rho_default * dh * dh);

  connect(plugFlowPipeZeta.heatPort, cylindricHeatTransfer_1.port_a)
    annotation (Line(points={{0,10},{0,30}}, color={191,0,0}));
  connect(cylindricHeatTransfer_1.port_b, cylindricHeatTransfer_2.port_a)
    annotation (Line(points={{0,38.8},{0,56}}, color={191,0,0}));
  connect(cylindricHeatTransfer_2.port_b,cylindricHeatTransfer_3. port_a)
    annotation (Line(points={{0,64.8},{0,82}}, color={191,0,0}));
  connect(cylindricHeatTransfer_3.port_b, heatPort)
    annotation (Line(points={{0,90.8},{0,104}}, color={191,0,0}));
  connect(port_a, plugFlowPipeZeta.port_a)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
  connect(plugFlowPipeZeta.ports_b, ports_b) annotation (Line(points={{10,0},{56,
          0},{56,0},{100,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,32},{100,-48}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,22},{100,-38}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-100,42},{100,32}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,-48},{100,-58}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Polygon(
          points={{2,94},{42,74},{22,74},{22,64},{-18,64},{-18,74},{-38,74},{2,94}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,22},{28,-38}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,202,187}),
        Rectangle(
          extent={{-100,72},{100,42}},
          lineColor={28,108,200},
          fillColor={162,29,33},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-100,-58},{100,-88}},
          lineColor={28,108,200},
          fillColor={162,29,33},
          fillPattern=FillPattern.Forward)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model represents an extension of <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Pipes.PlugFlowPipe\">AixLib.Fluid.DistrictHeatingCooling.Pipes.PlugFlowPipe</a>
  by modelling the thermal capacity of the surrounding soil. For the
  description of the cylindric heat transfer within the surrounding
  soil <a href=
  \"modelica://AixLib.Utilities.HeatTransfer.CylindricHeatTransfer\">AixLib.Utilities.HeatTransfer.CylindricHeatTransfer</a>
  is used. The considered layer thickness of the surrounding soil is
  set as a parameter and divided into three capacities. For the heat
  transfer calculation within the material/soil, the density, the
  specific heat capacity, the thickness of the considered soil layer
  and the thermal conductivity of the material are used.
</p>
<p>
  The default values for the soil are for sandy soil with clay content
  and based on: \"Simulationsmodell Erdwärmekollektor zur
  wärmetechnischen Beurteilung von Wärmequellen, Wärmesenken und
  Wärme-/Kältespeicher\" by Berd Glück
</p>
<h4>
  References
</h4>
<p>
  Full details on the model implementation and experimental validation
  can be found in:
</p>
<p>
  van der Heijde, B., Fuchs, M., Ribas Tugores, C., Schweiger, G.,
  Sartor, K., Basciotti, D., Müller, D., Nytsch-Geusen, C., Wetter, M.
  and Helsen, L. (2017).<br/>
  Dynamic equation-based thermo-hydraulic pipe model for district
  heating and cooling systems.<br/>
  <i>Energy Conversion and Management</i>, vol. 151, p. 158-169.
  <a href=\"https://doi.org/10.1016/j.enconman.2017.08.072\">doi:
  10.1016/j.enconman.2017.08.072</a>.
</p>
<ul>
  <li>November 21, 2019, by Nils Neuland:<br/>
    Model is now using PlugFlowPipe model from DistrictHeatingCooling
  </li>
  <li>July, 2018 by Tobias Blacha:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end PlugFlowPipeEmbedded;
