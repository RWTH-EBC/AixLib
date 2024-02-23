within AixLib.Fluid.Sensors;
model ModularSensors
  "Model that contains mass flow, pressure, temperature and quality sensors 
  for modular compressors"

  // Definition of parameters
  //
  parameter Modelica.Units.SI.Time tau=1 "Time constant at nominal flow rate"
    annotation (Dialog(tab="Sensors", group="General"));

  parameter Boolean transferHeat=false
    "if true, temperature T converges towards TAmb when no flow"
    annotation(Dialog(tab="Sensors",group="Temperature sensor"));
  parameter Modelica.Units.SI.Temperature TAmb=Medium.T_default
    "Fixed ambient temperature for heat transfer"
    annotation (Dialog(tab="Sensors", group="Temperature sensor"));
  parameter Modelica.Units.SI.Time tauHeaTra=1200
    "Time constant for heat transfer, default 20 minutes"
    annotation (Dialog(tab="Sensors", group="Temperature sensor"));

  parameter Modelica.Blocks.Types.Init initType=
    Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation(Dialog(tab="Sensors",group="Initialisation"));
  parameter Modelica.Units.SI.Temperature T_start=Medium.T_default
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Sensors", group="Initialisation"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_out_start=
      Medium.specificEnthalpy_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default) "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Sensors", group="Initialisation"));

  // Extensions
  //
  extends Interfaces.PartialModularPort_ab;

  // Definition of variables
  //
  Medium.SaturationProperties satPro[nPorts]
    "Saturation states for each fluid port";

  Modelica.Units.SI.SpecificEnthalpy bubEnt[nPorts]
    "Bubble enthalpies for each fluid port";
  Modelica.Units.SI.SpecificEnthalpy dewEnt[nPorts]
    "Dew enthalpies for each fluid port";
  Real pTriCri[nPorts]
    "Trigger to check if medium exceeds critical pressure";

  // Definition of models
  //
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo[nPorts](redeclare each final
      package                                                                      Medium =
                       Medium) "Mass flow sensors"
    annotation (Placement(transformation(extent={{-70,10},{-50,-10}})));
  AixLib.Fluid.Sensors.Pressure senPre[nPorts](redeclare each final package Medium =
               Medium) "Pressure sensors"
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem[nPorts](
    redeclare each final package Medium = Medium,
    each final m_flow_nominal=m_flow_nominal,
    each final m_flow_small=m_flow_small,
    each final tau=tau,
    each final initType=initType,
    each final T_start=T_start,
    each final transferHeat=transferHeat,
    each final TAmb=TAmb,
    each final tauHeaTra=tauHeaTra) "Temperature sensors"
    annotation (Placement(transformation(extent={{10,10},{30,-10}})));
  AixLib.Fluid.Sensors.SpecificEnthalpyTwoPort senSpeEnt[nPorts](
    redeclare each final package Medium = Medium,
    each final m_flow_nominal=m_flow_nominal,
    each final m_flow_small=m_flow_small,
    each final tau=tau,
    each final initType=initType,
    each final h_out_start=h_out_start) "Specific enthalpy sensors"
    annotation (Placement(transformation(extent={{50,10},{70,-10}})));

  // Definition of connectors
  //
  Modelica.Blocks.Interfaces.RealOutput meaPre[nPorts]
    "Pressures measured by sensors"
    annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-60,-100})));
  Modelica.Blocks.Interfaces.RealOutput meaTem[nPorts]
    "Temperatures measured by sensors"
    annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-20,-100})));
  Modelica.Blocks.Interfaces.RealOutput meaMasFlo[nPorts]
    "Mass flow rates measured by sensors"
    annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={20,-100})));
  Modelica.Blocks.Interfaces.RealOutput meaQua[nPorts]
    "Qualities measured by sensors"
    annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={60,-100})));

equation
  // Calculating vapour qualities
  //
  for i in 1:nPorts loop
    satPro[i] = Medium.setSat_p(senPre[i].p) "Set saturation properties";
    bubEnt[i] = Medium.bubbleEnthalpy(satPro[i]) "Calculate bubble enthalpies";
    dewEnt[i] = Medium.dewEnthalpy(satPro[i]) "Calculate dew enthalpies";
    pTriCri[i] = senPre[i].p/Medium.fluidConstants[1].criticalPressure
      "Check if medium exceeds critical pressure";
    meaQua
         [i] = noEvent(if (pTriCri[i]<1 and senSpeEnt[i].h_out<bubEnt[i]) then 0
     else if (pTriCri[i]<1 and senSpeEnt[i].h_out>bubEnt[i] and
     senSpeEnt[i].h_out<dewEnt[i]) then (senSpeEnt[i].h_out - bubEnt[i])/
     max(dewEnt[i] - bubEnt[i], 1e-6) else 1.0)
     "Calculate vapour qualities";
  end for;

  // Connection of sensors
  //
  for i in 1:nPorts loop
    connect(ports_a[i],senMasFlo[i].port_a);
    connect(senMasFlo[i].port_b,senPre[i].port);
    connect(senMasFlo[i].port_b,senTem[i].port_a);
    connect(senTem[i].port_b,senSpeEnt[i].port_a);
    connect(senSpeEnt[i].port_b,ports_b[i]);
  end for;

  // Connection of outputs
  //
  connect(meaPre,senPre.p);
  connect(meaTem,senTem.T);
  connect(meaMasFlo,senMasFlo.m_flow);

  annotation (Icon(graphics={
        Ellipse(
          fillColor={245,245,245},
          fillPattern=FillPattern.Solid,
          extent={{-70.0,-70.0},{70.0,70.0}}),
        Line(points={{0.0,70.0},{0.0,40.0}}),
        Line(points={{22.9,32.8},{40.2,57.3}}),
        Line(points={{-22.9,32.8},{-40.2,57.3}}),
        Line(points={{37.6,13.7},{65.8,23.9}}),
        Line(points={{-37.6,13.7},{-65.8,23.9}}),
        Ellipse(
          lineColor={64,64,64},
          fillColor={255,255,255},
          extent={{-12.0,-12.0},{12.0,12.0}}),
        Polygon(
          rotation=-17.5,
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-5.0,0.0},{-2.0,60.0},{0.0,65.0},{2.0,60.0},{5.0,0.0}}),
        Ellipse(
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{-7.0,-7.0},{7.0,7.0}})}),
                                 Documentation(revisions="<html><ul>
  <li>October 30, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a model of modular sensors that is used, for example, for
  components of modular heat pumps like modular expansion valves or
  modular compressors.<br/>
  It consists of four types of sensors that are introduced as vectors
  and that are mainly used in heat pumps:
</p>
<ul>
  <li>Absolute pressure.
  </li>
  <li>Temperature.
  </li>
  <li>Mass flow rate.
  </li>
  <li>Steam quality.
  </li>
</ul>
</html>"));
end ModularSensors;
