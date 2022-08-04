within AixLib.Fluid.Movers.Compressors.ModularCompressors;
model ModularCompressorsSensors
  "Model of simple modular compressors with sensors at each compressor's outlet"
  extends BaseClasses.PartialModularCompressors;

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

  // Definition of submodels and connectors
  //
  Sensors.ModularSensors modSen(
    redeclare final package Medium = Medium,
    final nPorts=nCom,
    final tau=tau,
    final transferHeat=transferHeat,
    final TAmb=TAmb,
    final tauHeaTra=tauHeaTra,
    final initType=initTypeSen,
    final T_start=T_start,
    final h_out_start=h_out_start,
    final m_flow_nominal=m_flow_nominal,
    final m_flow_small=1e-6*m_flow_nominal)
    "Model that contains different sensors located behind compressors"
    annotation (Placement(transformation(extent={{28,-10},{48,10}})));


equation
  // Connect compressors' port_b with sensors and sensors with port_b
  //
  for i in 1:nCom loop
    connect(modCom[i].port_b,modSen.ports_a[i]);
    connect(modSen.ports_b[i],port_b);
  end for;

  // Connect sensors
  //
  connect(modSen.meaPre, dataBus.senBus.meaPreCom)
    annotation (Line(points={{32,-10},{32,-90},{0.05,-90},{0.05,-99.95}},
                color={0,0,127}));
  connect(modSen.meaTem, dataBus.senBus.meaTemCom)
    annotation (Line(points={{36,-10},{36,-90},{0.05,-90},{0.05,-99.95}},
                color={0,0,127}));
  connect(modSen.meaMasFlo, dataBus.senBus.meaMasFloCom)
    annotation (Line(points={{40,-10},{40,-10},{40,-22},{40,-90},{0.05,-90},
                {0.05,-99.95}},color={0,0,127}));
  connect(modSen.meaQua, dataBus.senBus.meaPhaCom)
    annotation (Line(points={{44,-10},{44,-90},{0.05,-90},{0.05,-99.95}},
                color={0,0,127}));

  annotation (Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a model of modular compressors that are used, for example, in
  close-loop systems like heat pumps or chillers.<br/>
  It consists of <code>nCom</code> compressors in parallel and also
  <code>nCom</code> PID conrollers if no external controller is used.
  Additionally, four different sensors (i.e. absolute pressure,
  temperature, mass flow rate, steam quality) are located at each
  compressor's outlet.
</p>
<h4>
  Modeling approaches
</h4>
<p>
  This base model mainly consists of two sub-models. Therefore, please
  checkout these sub-models for further information of underlying
  modeling approaches and parameterisation:
</p>
<ul>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompressor\">
    AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompressor</a>.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Controls.HeatPump.ModularHeatPumps.ModularCompressorController\">
    AixLib.Controls.HeatPump.ModularHeatPumps.ModularCompressorController</a>.
  </li>
</ul>
<p>
  The first sub-model describes a simple compressor that is defined in
  <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.SimpleCompressors\">AixLib.Fluid.Movers.Compressors.SimpleCompressors</a>;
  the second sub-model describes the internal controller model.
</p>
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
        Diagram(graphics={        Line(points={{-100,0},{-10,0}},
                        color={0,127,255}),
                                  Line(points={{0,10},{0,100}},
                        color={191,0,0}),
                                  Line(points={{10,0},{28,4}},
                        color={0,127,255}),
                                  Line(points={{10,0},{28,-4}},
                        color={0,127,255}),
                                  Line(points={{10,0},{28,0}},
                        color={0,127,255}),
                                  Line(points={{48,4},{100,0}},
                        color={0,127,255}),
                                  Line(points={{48,-4},{100,0}},
                        color={0,127,255}),
                                  Line(points={{48,0},{100,0}},
                        color={0,127,255})}));
end ModularCompressorsSensors;
