within AixLib.Utilities.Logical;
model ValveControlLogicPIAbsdT "Controls a valve"

  Modelica.Blocks.Interfaces.RealOutput val_pos "position of the valve"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-420,-100}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-360,-100})));
  Modelica.Blocks.Interfaces.RealInput dT_Network "dT Network" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-480,100}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-480,100})));
  Modelica.Blocks.Interfaces.RealInput return_temp
    "Signal of the Netork Return Temperature"     annotation (Placement(
        transformation(extent={{-220,20},{-260,60}}),     iconTransformation(
          extent={{-220,20},{-260,60}})));
  Modelica.Blocks.Interfaces.RealInput supply_temp
    "Signal of the Network Supply Temperature"    annotation (Placement(
        transformation(extent={{-220,-60},{-260,-20}}),   iconTransformation(
          extent={{-220,-60},{-260,-20}})));
  Modelica.Blocks.Continuous.LimPID pControl(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.002,
    Ti=7,
    Td=0.1,
    yMax=1,
    yMin=0.1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.3)      "Pressure controller" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-426,26})));
  Modelica.Blocks.Sources.RealExpression open(y=1)
    annotation (Placement(transformation(extent={{-490,-40},{-474,-20}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=7200)
    annotation (Placement(transformation(extent={{-492,-16},{-474,2}})));
    Modelica.Blocks.Logical.Switch mass_flow_heatExchangerHeating1
    "calculation of mass flow through heat exchanger (heating)"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-420,-50})));
  Modelica.Blocks.Math.Add s_r(k1=1, k2=-1)
    annotation (Placement(transformation(extent={{-310,-10},{-330,10}})));
  Modelica.Blocks.Math.Abs dT_curr
    annotation (Placement(transformation(extent={{-362,-10},{-382,10}})));
equation
  connect(pControl.y,mass_flow_heatExchangerHeating1. u1) annotation (Line(
        points={{-426,15},{-426,-12},{-412,-12},{-412,-38}},
                                                        color={0,0,127}));
  connect(pControl.u_m, dT_curr.y) annotation (Line(points={{-414,26},{-404,26},
          {-404,0},{-383,0}}, color={0,0,127}));
  connect(dT_curr.u, s_r.y)
    annotation (Line(points={{-360,0},{-331,0}}, color={0,0,127}));
  connect(pControl.u_s, dT_Network) annotation (Line(points={{-426,38},{-426,60},
          {-480,60},{-480,100}}, color={0,0,127}));
  connect(return_temp, s_r.u1) annotation (Line(points={{-240,40},{-279,40},{
          -279,6},{-308,6}}, color={0,0,127}));
  connect(supply_temp, s_r.u2) annotation (Line(points={{-240,-40},{-280,-40},{
          -280,-6},{-308,-6}}, color={0,0,127}));
  connect(mass_flow_heatExchangerHeating1.y, val_pos)
    annotation (Line(points={{-420,-61},{-420,-100}}, color={0,0,127}));
  connect(mass_flow_heatExchangerHeating1.u2, booleanStep.y) annotation (Line(
        points={{-420,-38},{-420,-20},{-434,-20},{-434,-7},{-473.1,-7}}, color=
          {255,0,255}));
  connect(open.y, mass_flow_heatExchangerHeating1.u3) annotation (Line(points={
          {-473.2,-30},{-428,-30},{-428,-38}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-540,
            -80},{-260,80}}),  graphics={Rectangle(
          extent={{-540,80},{-260,-80}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
                              Text(
          extent={{-522,64},{-280,-62}},
          lineColor={0,0,0},
          textString="PI
Abs"),                                         Text(
          extent={{-460,120},{-260,80}},
          lineColor={0,0,255},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-540,-80},{-260,80}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br>Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end ValveControlLogicPIAbsdT;
