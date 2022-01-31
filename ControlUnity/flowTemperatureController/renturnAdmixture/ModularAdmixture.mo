within ControlUnity.flowTemperatureController.renturnAdmixture;
model ModularAdmixture

replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

     parameter Boolean use_advancedControl=true;
     parameter Boolean severalHeatcurcuits=true;


  Admixture admixture[k](
    redeclare package Medium = Medium,
    k=k,
    m_flow_nominalCon=m_flow_nominalCon,
    dp_nominalCon=dp_nominalCon,
    QNomCon=QNomCon,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    Kv=10) if use_advancedControl and severalHeatcurcuits annotation (Placement(
        transformation(
        extent={{-19,-19},{19,19}},
        rotation=0,
        origin={5,1})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a[k](redeclare package Medium =
        AixLib.Media.Water)
    annotation (Placement(transformation(extent={{-108,30},{-88,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b[k](redeclare package Medium =
        AixLib.Media.Water)
    annotation (Placement(transformation(extent={{88,30},{108,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1[k](redeclare package Medium =
        AixLib.Media.Water)
    annotation (Placement(transformation(extent={{-108,-50},{-88,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1[k](redeclare package Medium =
        AixLib.Media.Water)
    annotation (Placement(transformation(extent={{88,-52},{108,-30}})));
  parameter Integer k=2 "number of heat curcuits";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominalCon[:]
    "Nominal mass flow rate for the individual consumers";
  parameter Modelica.SIunits.PressureDifference dp_nominalCon[:]
    "Pressure drop at nominal conditions for the individual consumers";
  parameter Modelica.SIunits.HeatFlowRate QNomCon[:] "Nominal heat power that the consumers need";
  AdmixtureBus admixtureBus[k] annotation (Placement(transformation(extent={{
            -12,82},{22,108}}), iconTransformation(extent={{-12,82},{22,108}})));
equation
  connect(port_a, admixture.port_a1) annotation (Line(points={{-98,40},{-58,40},{-58,12.4},{-14,12.4}},
        color={0,127,255}));
  connect(admixture.port_b1, port_b)
    annotation (Line(points={{24,12.4},{74,12.4},{74,40},{98,40}}, color={0,127,255}));
  connect(admixture.port_a2, port_a1) annotation (Line(points={{24,-10.4},{62,-10.4},{62,-41},{98,
          -41}}, color={0,127,255}));
  connect(admixture.port_b2, port_b1) annotation (Line(points={{-14,-10.4},{-20,-10.4},{-20,-10},
          {-56,-10},{-56,-40},{-98,-40}}, color={0,127,255}));
  connect(admixtureBus, admixture.admixtureBus) annotation (Line(
      points={{5,95},{5,57.5},{5,57.5},{5,19.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end ModularAdmixture;
