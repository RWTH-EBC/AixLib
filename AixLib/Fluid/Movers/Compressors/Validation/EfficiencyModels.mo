within AixLib.Fluid.Movers.Compressors.Validation;
model EfficiencyModels
  "Validation model to check efficiencies calculated with respect to different 
  prescribed conditions"
  extends Modelica.Icons.Example;

  // Define medium and parameters
  //
  package Medium =
   Modelica.Media.R134a.R134a_ph
   "Actual medium of the compressor";

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.1
    "Nominal mass flow rate";

  // Definition of variables
  //
  Modelica.Units.SI.AbsolutePressure pInl=Medium.pressure(Medium.setBubbleState(
      Medium.setSat_T(preInp.y[2] - 1))) "Actual pressure at inlet conditions";
  Modelica.Units.SI.AbsolutePressure pOut=Medium.pressure(Medium.setDewState(
      Medium.setSat_T(preInp.y[3] - 1)))
    "Actual set point of the compressor's outlet pressure";

  // Definition of models
  //
  Modelica.Blocks.Sources.CombiTimeTable preInp(
    tableOnFile=true,
    tableName="Internals",
    fileName=Modelica.Utilities.Files.loadResource(
      "modelica://AixLib/Resources/Fluid/Movers/Compressors/efficiencyValidation.txt"),
    columns=2:5,
    extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    "Prescribed inputs to check efficiencies calculated by efficiency models"
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature fixTem
    "Fixed ambient temperature"
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Blocks.Sources.RealExpression pInlDum(y=pInl)
    "Dummy to succeed pedantic check"
    annotation (Placement(transformation(extent={{-44,4},{-36,12}})));
  Modelica.Blocks.Sources.RealExpression pOutDum(y=pOut)
    "Dummy to succeed pedantic check"
    annotation (Placement(transformation(extent={{66,4},{58,12}})));

  Sources.Boundary_pT source(
    redeclare package Medium = Medium,
    nPorts=1,
    use_T_in=true,
    use_p_in=true) "Source of constant pressure and temperature"
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  replaceable SimpleCompressors.RotaryCompressors.RotaryCompressor rotCom(
    redeclare package Medium = Medium,
    show_staEff=true,
    show_qua=true,
    useInpFil=false,
    redeclare model EngineEfficiency =
        Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
    redeclare model VolumetricEfficiency =
        Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
    redeclare model IsentropicEfficiency =
        AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll)
    "Model of a rotary compressor"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Sources.Boundary_pT sink(
    redeclare package Medium = Medium,
    use_T_in=true,
    use_p_in=true,
    nPorts=1) "Sink with constant pressure and temperature"
    annotation (Placement(transformation(extent={{50,-10},{30,10}})));


equation
  // Connection of components
  //
  connect(source.ports[1],rotCom. port_a)
    annotation (Line(points={{-10,0},{0,0}}, color={0,127,255}));
  connect(fixTem.port,rotCom. heatPort)
    annotation (Line(points={{-10,-40},{10,-40},{10,-10}}, color={191,0,0}));
  connect(rotCom.port_b, sink.ports[1])
    annotation (Line(points={{20,0},{30,0}}, color={0,127,255}));
  connect(preInp.y[1], fixTem.T)
    annotation (Line(points={{-69,80},{-50,80},{-50,-40},{-32,-40}},
                color={0,0,127}));
  connect(preInp.y[2], source.T_in)
    annotation (Line(points={{-69,80},{-50,80},{-50,4},{-32,4}},
                color={0,0,127}));
  connect(preInp.y[3], sink.T_in)
    annotation (Line(points={{-69,80},{-50,80},{-50,-60},{70,-60},{70,4},{52,4}},
                                         color={0,0,127}));
  connect(preInp.y[4],rotCom. manVarCom)
    annotation (Line(points={{-69,80},{-50, 80},{-50,60},{4,60},{4,10}},
                color={0,0,127}));
  connect(pOutDum.y, sink.p_in)
    annotation (Line(points={{57.6,8},{52,8}},
                                             color={0,0,127}));
  connect(pInlDum.y, source.p_in)
    annotation (Line(points={{-35.6,8},{-32,8}},
                                               color={0,0,127}));

  annotation (experiment(StopTime=21168), Documentation(revisions="<html><ul>
  <li>October 24, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a validation model to test various efficiency models
  presented in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency</a>,
  <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency</a>
  and <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency</a>.
  Therefore, both the compressor's inlet and outlet conditions are
  prescribed in terms of pressure and temperature; additionally, the
  ambient temperature as well as the rotational speed of the compressor
  are prescribed. These four variables are varied in the following
  range:
</p>
<ul>
  <li>Ambient temperature: -20 - 20 °C
  </li>
  <li>Inlet temperature: -20 - 20 °C
  </li>
  <li>Outlet temperature: 40 - 70 °C
  </li>
  <li>Rotational speed: 40 - 120 Hz
  </li>
</ul>
<p>
  The pressures at inlet and outlet of the compressor depend on the
  temperatures at inlet and outlet of the compressor. Thus, it is
  possible to check if the efficiency models provide efficiencies that
  are physically correct (i.e. to check if the efficiencies are smaller
  than unity).
</p>
</html>"));
end EfficiencyModels;
