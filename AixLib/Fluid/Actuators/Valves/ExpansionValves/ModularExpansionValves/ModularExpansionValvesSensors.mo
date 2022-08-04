within AixLib.Fluid.Actuators.Valves.ExpansionValves.ModularExpansionValves;
model ModularExpansionValvesSensors
  "Model of modular expansion valves, i.g. each valves is in front 
  of an evaporator, combined with sensors"
  extends BaseClasses.PartialModularExpansionVavles;

  // Definition of parameters
  //
  parameter Modelica.Units.SI.Time tau=1 "Time constant at nominal flow rate"
    annotation (Dialog(tab="General", group="Sensors"), HideResult=not
        show_parSen);

  parameter Boolean transferHeat = false
    "if true, temperature T converges towards TAmb when no flow"
    annotation(Dialog(tab="General",group="Sensors"),
               HideResult=not show_parSen);
  parameter Modelica.Units.SI.Temperature TAmb=Medium.T_default
    "Fixed ambient temperature for heat transfer" annotation (Dialog(tab=
          "General", group="Sensors"), HideResult=not show_parSen);
  parameter Modelica.Units.SI.Time tauHeaTra=1200
    "Time constant for heat transfer, default 20 minutes" annotation (Dialog(
        tab="General", group="Sensors"), HideResult=not show_parSen);

  parameter Modelica.Blocks.Types.Init initTypeSen=
    Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation(Dialog(tab="Advanced",group="Initialisation Sensors"),
               HideResult=not show_parSen);
  parameter Modelica.Units.SI.Temperature T_start=Medium.T_default
    "Initial or guess value of output (= state)" annotation (Dialog(tab=
          "Advanced", group="Initialisation Sensors"), HideResult=not
        show_parSen);
  parameter Modelica.Units.SI.SpecificEnthalpy h_out_start=
      Medium.specificEnthalpy_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default) "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Advanced", group="Initialisation Sensors"),
      HideResult=not show_parSen);

  parameter Boolean show_parSen = false
    "= true, if sensors' input parameters are shown in results"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  // Definition of models
  //
  Utilities.ModularSensors modularSensors(
    redeclare final package Medium = Medium,
    final nPorts=nVal,
    final m_flow_nominal=m_flow_nominal,
    final m_flow_small=1e-6*m_flow_nominal,
    final tau=tau,
    final transferHeat=transferHeat,
    final TAmb=TAmb,
    final tauHeaTra=tauHeaTra,
    final initType=initTypeSen,
    final T_start=T_start,
    final h_out_start=h_out_start)
    "Model that contains different sensors located behind expansion valves"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));


equation
  // Connect expansion valves with sensors and sensors with ports_b
  //
  for i in 1:nVal loop
    connect(modExpVal[i].port_b, modularSensors.ports_a[i]);
    connect(modularSensors.ports_b[i],ports_b[i]);
  end for;

  // Connect sensors with data bus
  //
  connect(modularSensors.preMea, dataBus.senBus.meaPreVal)
    annotation (Line(points={{34,-10},{34,-90},{0.05,-90},{0.05,-99.95}},
                color={0,0,127}));
  connect(modularSensors.temMea, dataBus.senBus.meaTemVal)
    annotation (Line(points={{38,-10},{38,-90},{0.05,-90},{0.05,-99.95}},
                color={0,0,127}));
  connect(modularSensors.masFloMea, dataBus.senBus.meaMasFloVal)
    annotation (Line(points={{42,-10},{42,-90},{0.05,-90},{0.05,-99.95}},
                color={0,0,127}));
  connect(modularSensors.quaMea, dataBus.senBus.meaPhaVal)
    annotation (Line(points={{46,-10},{46,-10},{46,-20},{46,-90},{0.05,-90},{0.05,
          -99.95}},color={0,0,127}));

  annotation (Documentation(revisions="<html><ul>
  <li>October 17, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a model of modular expansion valves that are used, for
  example, in close-loop systems like heat pumps or chillers.<br/>
  It consists of <code>nVal</code> expansion valves in parallel and
  also <code>nVal</code> PID conrollers if no external controller is
  used. Additionally, four different sensors (i.e. absolute pressure,
  temperature, mass flow rate, steam quality) are located at each
  expansion valve's outlet.
</p>
<h4>
  Modeling approaches
</h4>
<p>
  This base model mainly consists of three sub-models. Therefore,
  please checkout these sub-models for further information of
  underlying modeling approaches and parameterisation:
</p>
<ul>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve\">
    AixLib.Fluid.Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve</a>.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController\">
    AixLib.Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController</a>.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.ModularSensors\">
    AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.ModularSensors</a>.
  </li>
</ul>
</html>"), Icon(graphics={
        Rectangle(
          extent={{38,34},{82,-34}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          fillColor={245,245,245},
          fillPattern=FillPattern.Solid,
          extent={{40,-20},{80,20}}),
        Line(points={{60,20},{60,12}}),
        Line(points={{66,10},{70.2,17.3}}),
        Line(points={{54,10},{49.8,17.3}}),
        Line(points={{70,4},{77.8,7.9}}),
        Line(points={{50,4},{42.2,7.9}}),
        Ellipse(
          lineColor={64,64,64},
          fillColor={255,255,255},
          extent={{54,-6},{66,6}}),
        Ellipse(
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{56,-4},{64,4}}),
        Polygon(
          points={{60,2},{62,0},{68,6},{70,10},{66,8},{60,2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Diagram(graphics={
                    Line(points={{-100,0},{-10,0}},color={0,127,255}),
                    Line(points={{50,2},{100,14}}, color={0,127,255}),
                    Line(points={{50,0},{100,0}},  color={0,127,255}),
                    Line(points={{50,-2},{100,-14}},color={0,127,255}),
                    Line(points={{10,0},{30,4}},   color={0,127,255}),
                    Line(points={{10,0},{30,-4}},  color={0,127,255}),
                    Line(points={{10,0},{30,0}},   color={0,127,255})}));
end ModularExpansionValvesSensors;
